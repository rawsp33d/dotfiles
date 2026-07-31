local sync = Module.new("sync", "<space>s")
local hunks = Module.new("hunks", "<space>h")

pack "lewis6991/gitsigns.nvim"

--
-- SETUP
--

require("mini.git").setup()
require("mini.diff").setup({
	options = {
		wrap_goto = true,
	},
})

local gitsigns = require("gitsigns")
gitsigns.setup({
	on_attach = function(bufnr)
		-- text object
		map("ih", gitsigns.select_hunk, { "o", "x" })

		-- toggles
		hunks:map([[\b]], gitsigns.toggle_current_line_blame)
		hunks:map([[\w]], gitsigns.toggle_word_diff)

		-- stage hunks
		hunks:map("s", gitsigns.stage_hunk)
		hunks:map("s", function()
			gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
		end, { "v" })
		hunks:map("l", function()
			gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line(".") })
		end)

		-- reset hunks
		hunks:map("r", gitsigns.reset_hunk)
		hunks:map("r", function()
			gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
		end, { "v" })

		-- stage buffer
		hunks:map("S", gitsigns.stage_buffer)

		-- reset buffer
		hunks:map("R", gitsigns.reset_buffer)

		-- previews
		hunks:map("p", gitsigns.preview_hunk)
		hunks:map("i", gitsigns.preview_hunk_inline)

		-- blame
		hunks:map("b", function()
			gitsigns.blame_line({ full = true })
		end)

		-- diff
		hunks:map("d", gitsigns.diffthis)
		hunks:map("D", function()
			gitsigns.diffthis("origin")
		end)

		-- replog
		hunks:map("q", gitsigns.setqflist)
		hunks:map("Q", function()
			gitsigns.setqflist("all")
		end)
	end,
})

--
-- MAPPINGS
--

local tigs = utils.Term:new({
	cmd = "tig status",
	persist_mode = true,
})

sync:map("<space>", function()
	tigs:toggle "float"
end)

sync:map("t", function()
	tigs:toggle "tab"
end)

sync:map("w", function()
	tigs:toggle "window"
end)

sync:map("j", function()
	tigs:toggle "below"
end)

sync:map("k", function()
	tigs:toggle "above"
end)

sync:map("h", function()
	tigs:toggle "left"
end)

sync:map("l", function()
	tigs:toggle "right"
end)

local gitui = utils.Term:new({
	cmd = "gitui",
	persist_mode = true,
})

sync:map("u", function()
	gitui:toggle "float"
end)

hunks:map("c", function()
	MiniGit.show_at_cursor()
end)
