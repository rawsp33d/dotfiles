local tabs = Module.new("tabs", "<space>t")

--
-- MAPPINGS
--

-- relatave navigation
local next_tab = cmd [[<c-u>execute (v:count == 0) ? "tabnext" : "tabnext " . (v:count1 + 2)]]
local prev_tab = cmd [[<c-u>execute (v:count == 0) ? "tabprevious" : "tabprevious " . v:count1]]
tabs:map("h", prev_tab, [[nav: previous]])
tabs:map("l", next_tab, [[nav: next]])

-- absolute navigation
map("<a-`>", cmd "tabfirst", [[nav: first]])
map("<a-0>", cmd "tablast", [[nav: last]])

-- direct navigation
for i = 1, 9, 1 do
	map("<a-" .. i .. ">", i .. "gt", [[nav: #]] .. i)
end

-- alt-tab (pun)
map("<a-tab>", "g<tab>", [[nav: prior]])

-- move [±n:1] tabs
tabs:map("H", cmd [[<c-u>execute "tabmove -" . v:count1]], [[move tab right]])
tabs:map("L", cmd [[<c-u>execute "tabmove +" . v:count1]], [[move tab left]])

-- new
tabs:map("n", cmd "tabedit", [[open empty tab]])
tabs:map("N", cmd "tabedit %", [[open buffer new tab]])
tabs:map("p", cmd "-tabedit", [[open empty tab before current]])

-- close
tabs:map("c", cmd "tabclose", [[close tab]])
tabs:map("C", cmd "tabclose!", [[close! tab]])

-- close others
tabs:map("o", cmd "tabonly", [[close other tabs]])
tabs:map("O", cmd "tabonly!", [[close! other tabs]])
