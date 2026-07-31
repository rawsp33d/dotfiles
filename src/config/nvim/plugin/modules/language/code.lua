local code = Module.new("code", "<space>c")

pack "monaqa/dial.nvim"

--
-- SETTINGS
--

-- indents
vim.opt.shiftwidth = 0
vim.opt.tabstop = 2

-- spelling
vim.opt.spell = true
vim.opt.spelllang = "en_us"

-- meta
vim.opt.swapfile = false

-- langs
vim.g.rust_recommended_style = false

--
-- FUCTIONS
--

local augend = require "dial.augend"
local constant = function(elements, options)
	options = options or {}
	options.elements = elements
	if options.preserve_case == nil then options.preserve_case = true end
	return augend.constant.new(options)
end

--
-- SETUP
--

require("mini.align").setup()
require("mini.splitjoin").setup()
require("mini.surround").setup()

require("mini.pairs").setup({
	mappings = {
		-- Prevents the action if the cursor is just before any character or next to a "\".
		["("] = { action = "open", pair = "()", neigh_pattern = "[^\\][%s%)%]%}]" },
		["["] = { action = "open", pair = "[]", neigh_pattern = "[^\\][%s%)%]%}]" },
		["{"] = { action = "open", pair = "{}", neigh_pattern = "[^\\][%s%)%]%}]" },
		-- This is default (prevents the action if the cursor is just next to a "\").
		[")"] = { action = "close", pair = "()", neigh_pattern = "[^\\]." },
		["]"] = { action = "close", pair = "[]", neigh_pattern = "[^\\]." },
		["}"] = { action = "close", pair = "{}", neigh_pattern = "[^\\]." },
		-- Prevents the action if the cursor is just before or next to any character.
		['"'] = { action = "closeopen", pair = '""', neigh_pattern = "[^%w][^%w]", register = { cr = false } },
		["'"] = { action = "closeopen", pair = "''", neigh_pattern = "[^%w][^%w]", register = { cr = false } },
		["`"] = { action = "closeopen", pair = "``", neigh_pattern = "[^%w][^%w]", register = { cr = false } },
	},
})

require("mini.move").setup({
	mappings = {
		down = "<down>",
		left = "<left>",
		right = "<right>",
		up = "<up>",

		line_down = "<down>",
		line_left = "<left>",
		line_right = "<right>",
		line_up = "<up>",
	}
})

require("dial.config").augends:register_group({
	default = {
		augend.constant.alias.bool,
		augend.date.alias["%H:%M"],
		augend.date.alias["%Y-%m-%d"],
		augend.date.alias["%Y/%m/%d"],
		augend.date.alias["%m/%d"],
		augend.date.alias["%m/%d/%Y"],
		augend.integer.alias.binary,
		augend.integer.alias.decimal_int,
		augend.integer.alias.hex,
		augend.integer.alias.octal,
		augend.semver.alias.semver,

		constant({ "&&", "||" }, { word = false }),
		constant({ "True", "False" }),
		constant({ "and", "or" }),
		constant({ "before", "after" }, { word = false }),
		constant({ "high", "low" }),
		constant({ "mon", "tues", "wed", "thurs", "fri", "sat", "sun" }),
		constant({ "monday", "tuesday", "wednesday", "thursday", "friday", "saturday", "sunday" }, { word = false }),
		constant({ "on", "off" }),
		constant({ "start", "stop" }),
		constant({ "up", "down", "left", "right" }),
		constant({ "yes", "no" }),
		constant({ "inner", "outer" }),
		constant({ "next", "previous" }, { word = false }),
	},
})

--
-- MAPPINGS
--

-- enhancements

-- delete word
map("<c-backspace>", "<c-w>", { "i", desc = "delete word" })

-- redo
map("U", "<c-r>", "redo")

-- jump forth
map("<c-u>", "<c-i>", "jump forth")

-- find
map("<leader>/", [[/\v]], "very magic find")

-- increment/decrement
local dial = require "dial.map"
map("<c-a>", dial.inc_normal(), "increment")
map("<c-x>", dial.dec_normal(), "decrement")

local mini_pick = require "mini.pick"
code:map("s", mini_pick.registry.spellsuggest, "pick: spelling")

map("grd", vim.lsp.buf.definition, "lsp: goto definition")
map("grf", vim.lsp.buf.format, "lsp: fmt")

 -- spaces -> tabs
code:map("t", function()
	vim.cmd("%s/    /\t/")
end, "4 spaces -> tabs")

--
-- EVENTS
--

-- preserve cursor position [:h restore-cursor]
vim.api.nvim_create_autocmd("BufRead", {
	group = code.group,
	command = [[
		if line("'\"") > 1 && line("'\"") <= line("$") | exec "normal! g`\"" | endif
	]],
})
