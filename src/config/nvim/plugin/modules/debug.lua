local debug = Module.new("debug", "<space>d")

pack "folke/trouble.nvim"

--
-- SETUP
--

require("trouble").setup()

--
-- MAPPINGS
--

local mini_pick = require "mini.pick"
debug:map("<space>", function()
	vim.print(mini_pick.registry)
end)
