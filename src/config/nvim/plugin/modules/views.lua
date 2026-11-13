local views = Module.new("views", "<space>v")

local mini_pick = require "mini.pick"

--
-- SETTINGS
--

-- vim.o.switchbuf = "usetab"

--
-- MAPPINGS
--

-- choose
views:map("<space>", mini_pick.registry.buffers)

-- relative nav
map("<a-j>", function() pcall(vim.cmd, "wincmd j") end, { "n", "v", "o", "t", desc = [[nav: down]] })
map("<a-k>", function() pcall(vim.cmd, "wincmd k") end, { "n", "v", "o", "t", desc = [[nav: up]] })
map("<a-h>", function() pcall(vim.cmd, "wincmd h") end, { "n", "v", "o", "t", desc = [[nav: left]] })
map("<a-l>", function() pcall(vim.cmd, "wincmd l") end, { "n", "v", "o", "t", desc = [[nav: right]] })
map("<a-n>", cmd "bnext", [[nav: next]])
map("<a-p>", cmd "bprevious", [[nav: previous]])

-- stack nav
views:map("n", cmd "bnext", [[nav: next]])
views:map("p", cmd "bprevious", [[nav: previous]])
views:map("N", cmd "blast", [[nav: first]])
views:map("P", cmd "bfirst", [[nav: last]])

-- switch to alternate buffer
views:map("a", "<c-^>", [[nav: alt]])

-- split [wasd]
views:map("j", cmd "rightbelow new", [[split: down]])
views:map("k", cmd "leftabove new", [[split: up]])
views:map("h", cmd "leftabove vnew", [[split: left]])
views:map("l", cmd "rightbelow vnew", [[split: right]])

-- clone [wasd]
views:map("J", cmd "rightbelow split", [[clone: down]])
views:map("K", cmd "leftabove split", [[clone: up]])
views:map("H", cmd "leftabove vsplit", [[clone: left]])
views:map("L", cmd "rightbelow vsplit", [[clone: right]])

-- close
map("<a-q>", cmd "bdelete", [[bdelete]])
views:map("c", cmd "bdelete", [[bdelete]])
views:map("C", cmd "bdelete!", [[bdelete!]])

-- quit
views:map("q", cmd "quit", [[:quit]])
views:map("Q", cmd "quit!", [[:quit!]])

-- write
map("<c-s-s>", cmd "write", [[:write]])
views:map("w", cmd "write", [[:write]])
views:map("W", cmd "write!", [[:write!]])

-- save
views:map("s", cmd "update", [[:update]])
views:map("S", cmd "update!", [[:update!]])

-- exit
views:map("x", cmd "exit", [[:exit]])
views:map("X", cmd "exit!", [[:exit!]])

-- reload
views:map("r", cmd "edit", [[:edit]])
views:map("R", cmd "edit!", [[:edit!]])

-- source
views:map("u", cmd "source", [[:source]])
