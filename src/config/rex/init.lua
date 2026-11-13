local function bind(keys, action, args)
	rex.bind("ctrl+space>" .. keys, action, args)
end

-- nested prefix
bind("ctrl+space", "com.superlogical.terminal.write", { data = "\0" })

bind("d", "detach")
bind("z", "pane.zoom")
bind("o", "pane.next")
bind("x", "pane.close")

bind("p", "tab.previous")
bind("n", "tab.next")
bind("shift+p", "tab.new", { side = "before" })
bind("shift+n", "tab.new", { side = "after" })

bind("s>space", "session.choose")
bind("s>d", "detach")
bind("s>n", "session.new")
bind("s>z", "session.jump")
bind("s>r", "session.rename")
bind("s>x", "session.close")
bind("s>h", "session.previous")
bind("s>l", "session.next")
bind("shift+9", "session.previous")
bind("shift+0", "session.next")

bind("t>h", "tab.previous")
bind("t>l", "tab.next")

bind("t>p", "tab.new", { side = "before" })
bind("t>n", "tab.new", { side = "after" })
bind("t>x", "tab.close")
bind("t>r", "tab.rename")

for key, dir in pairs({ h = "left", l = "right" }) do
	bind("t>shift+" .. key, "tab.move", { direction = dir })
end
bind("shift+,", "tab.move", { direction = "left" })
bind("shift+.", "tab.move", { direction = "right" })
for i = 1, 9 do
	bind(tostring(i), "client.tab.goto", { index = i })
end
bind("0", "client.tab.goto", { index = -1 })

bind("v>c", "pane.close")

for key, dir in pairs({ h = "left", j = "down", k = "up", l = "right" }) do
	bind(key, "pane.focus", { direction = dir })
	bind(dir, "pane.focus", { direction = dir })
	bind("v>" .. key, "pane.split", { direction = dir })
	bind("v>shift+" .. key, "pane.swap", { direction = dir })
	bind("shift+" .. dir, "pane.swap", { direction = dir })
	bind("shift+" .. key, "pane.resize", { direction = dir, cells = 5 })
end

bind("\\", "pane.last")
bind("tab", "tab.last")

for key, layout in pairs({ j = "even-vertical", k = "even-vertical", h = "even-horizontal", l = "even-horizontal" }) do
	bind("w>" .. key, "tab.layout", { layout = layout })
end
for key, layout in pairs({ j = "main-vertical", k = "main-vertical", h = "main-horizontal", l = "main-horizontal" }) do
	bind("w>shift+" .. key, "tab.layout", { layout = layout })
end
bind("w>space", "tab.layout", { layout = "tiled" })
bind("w>n", "tab.layout", { layout = "next" })
bind("w>p", "tab.layout", { layout = "previous" })

-- popups: RX_PANE is the pane below
bind("f>c", "layer.new", { command = "nu -c 'rex send -b $env.RX_PANE (fd --type file --hidden --follow | fzf)'" })
bind("f>d", "layer.new", { command = "nu -c 'rex send -b $env.RX_PANE (fd --type directory --hidden --follow | fzf)'" })
bind("r", "layer.new", { command = "nu -c 'rex send -b $env.RX_PANE (history | get command | reverse | uniq | str join (char nl) | fzf)'" })
-- last arg, like tmux's run -b
bind(".", "pane.run", { command = "nu -c 'rex send -b $env.RX_PANE (history | last | get command | split row (char space) | last)'" })

bind("m", "mouse.toggle")

-- copy mode takes vi keys itself
bind("c", "pane.copy")
bind("v>p", "pane.paste")
