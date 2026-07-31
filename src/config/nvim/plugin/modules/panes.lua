local panes = Module.new("panes", "<space>p")

local mini_pick = require "mini.pick"

--
-- SETTINGS
--

-- vim.o.switchbuf = "usetab"

--
-- MAPPINGS
--

-- choose
panes:map("<space>", mini_pick.registry.buffers)

-- relative nav
map("<a-j>", function() pcall(vim.cmd, "wincmd j") end, { "n", "v", "o", "t", desc = "nav: down" })
map("<a-k>", function() pcall(vim.cmd, "wincmd k") end, { "n", "v", "o", "t", desc = "nav: up" })
map("<a-h>", function() pcall(vim.cmd, "wincmd h") end, { "n", "v", "o", "t", desc = "nav: left" })
map("<a-l>", function() pcall(vim.cmd, "wincmd l") end, { "n", "v", "o", "t", desc = "nav: right" })
map("<a-n>", cmd "bnext", "nav: next")
map("<a-p>", cmd "bprevious", "nav: previous")

-- stack nav
panes:map("n", cmd "bnext", "nav: next")
panes:map("p", cmd "bprevious", "nav: previous")
panes:map("N", cmd "blast", "nav: first")
panes:map("P", cmd "bfirst", "nav: last")

-- switch to alternate buffer
panes:map("a", "<c-^>", "nav: alt")

-- split [wasd]
panes:map("j", cmd "rightbelow new", "split: down")
panes:map("k", cmd "leftabove new", "split: up")
panes:map("h", cmd "leftabove vnew", "split: left")
panes:map("l", cmd "rightbelow vnew", "split: right")

-- clone [wasd]
panes:map("J", cmd "rightbelow split", "clone: down")
panes:map("K", cmd "leftabove split", "clone: up")
panes:map("H", cmd "leftabove vsplit", "clone: left")
panes:map("L", cmd "rightbelow vsplit", "clone: right")

-- close
map("<a-q>", cmd "bdelete", "bdelete")
panes:map("c", cmd "bdelete", "bdelete")
panes:map("C", cmd "bdelete!", "bdelete!")

-- quit
panes:map("q", cmd "quit", ":quit")
panes:map("Q", cmd "quit!", ":quit!")

-- write
map("<c-s-s>", cmd "write", ":write")
panes:map("w", cmd "write", ":write")
panes:map("W", cmd "write!", ":write!")

-- save
panes:map("s", cmd "update", ":update")
panes:map("S", cmd "update!", ":update!")

-- exit
panes:map("x", cmd "exit", ":exit")
panes:map("X", cmd "exit!", ":exit!")

-- reload
panes:map("r", cmd "edit", ":edit")
panes:map("R", cmd "edit!", ":edit!")

-- source
panes:map("u", cmd "source", ":source")
