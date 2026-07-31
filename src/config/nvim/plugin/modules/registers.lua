local registers = Module.new("registers", "<space>r")

--
-- MAPPINGS
--

-- fit in with mini.nvim
map("gP", [["+P]])
map("gY", [["+Y]], { "n", "x", remap = true })
map("g:", [["+g.]], { "n", "x", remap = true })

-- system clipboard [CLIPBOARD]
registers:map("", [["+]], "reg: system (CLIPBOARD)")

-- selection clipboard [PRIMARY]
registers:map("s", [["*]], "reg: selection (PRIMARY)")

-- blackhole register
registers:map("b", [["_]], "reg: blackhole")

-- yank register
registers:map("y", [["0]], "reg: yank")

-- delete register
registers:map("d", [["1]], "reg: delete")

-- small-delete register
registers:map("D", [["-]], "reg: small-delete")

-- search register
registers:map("/", [["/]], "reg: search")

-- expression register
registers:map("=", [["=]], "reg: expression")

-- read-only

-- insert register
registers:map("i", [[".]], "reg: insert")

-- command register
registers:map(";", [[":]], "reg: command")

-- file register
registers:map("f", [["%]], "reg: file")

-- alt-file register
registers:map("F", [["#]], "reg: alt-file")
