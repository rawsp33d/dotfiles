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
		map("ih", gitsigns.select_hunk, { "o", "x", desc = [[hunks]] })

		-- toggles
		hunks:map([[\b]], gitsigns.toggle_current_line_blame, [[toggle current line blame]])
		hunks:map([[\w]], gitsigns.toggle_word_diff, [[toggle word diff]])

		-- un/stage hunks
		hunks:map("s", gitsigns.stage_hunk, [[un/stage hunk]])
		hunks:map("s", function()
			gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
		end, { "v", desc = [[un/stage selected hunk]] })
		hunks:map("1", function()
			gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line(".") })
		end, [[un/stage line]])

		-- reset hunks
		hunks:map("r", gitsigns.reset_hunk, [[reset hunk]])
		hunks:map("r", function()
			gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
		end, { "v", desc = [[reset selected hunk]] })
		hunks:map("0", function()
			gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line(".") })
		end, [[reset line]])

		-- un/stage buffer
		hunks:map("S", gitsigns.stage_buffer, [[un/stage entire buffer]])

		-- reset buffer
		hunks:map("R", gitsigns.reset_buffer, [[reset entire buffer to HEAD]])

		-- previews
		hunks:map("p", gitsigns.preview_hunk, [[show diff preview]])
		hunks:map("i", gitsigns.preview_hunk_inline, [[show diff preview inline]])

		-- blame
		hunks:map("b", function()
			gitsigns.blame_line({ full = true })
		end, [[blame line]])

		-- diff
		hunks:map("d", gitsigns.diffthis, [[diff vs. HEAD]])
		hunks:map("D", function()
			gitsigns.diffthis("origin")
		end, [[diff vs. origin]])

		-- replog
		hunks:map("q", gitsigns.setqflist, [[show replog]])
		hunks:map("Q", function()
			gitsigns.setqflist("all")
		end, [[show replog for repo]])
	end,
})

--
-- MAPPINGS
--

local gitui = utils.Term:new({
	cmd = "gitui",
	persist_mode = true,
})

sync:map("<space>", function()
	gitui:toggle "float"
end, [[gitui (floating)]])

sync:map("t", function()
	gitui:toggle "tab"
end, [[gitui (tab)]])

sync:map("w", function()
	gitui:toggle "window"
end, [[gitui (new window)]])

sync:map("j", function()
	gitui:toggle "below"
end, [[gitui (below)]])

sync:map("k", function()
	gitui:toggle "above"
end, [[gitui (above)]])

sync:map("h", function()
	gitui:toggle "left"
end, [[gitui (left)]])

sync:map("l", function()
	gitui:toggle "right"
end, [[gitui (right)]])

local gitui = utils.Term:new({
	cmd = "gitui",
	persist_mode = true,
})

sync:map("u", function()
	gitui:toggle "float"
end, [[gitui (floating)]])

hunks:map("c", function()
	MiniGit.show_at_cursor()
end, [[show diff at cursor]])
