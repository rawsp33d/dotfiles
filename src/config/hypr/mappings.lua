local v = require("vars")
local dsp = hl.dsp
local hy3 = hl.plugin.hy3

local function exec(cmd)
	return dsp.exec_cmd(cmd)
end

-- run a dispatcher then leave the submap
local function once(d)
	return function()
		hl.dispatch(d)
		hl.dispatch(dsp.submap("reset"))
	end
end

local function exits()
	hl.bind("SUPER + ALT + space", dsp.submap("reset"))
	hl.bind("escape", dsp.submap("reset"))
	hl.bind("q", dsp.submap("reset"))
end

local dirs = { h = "left", j = "down", k = "up", l = "right" }

local function active()
	local w = hl.get_active_window()
	return w and w.address
end

-- actions
hl.bind("SUPER + Q", dsp.window.close())
hl.bind("SUPER + backslash", exec("nu -l -c 'notify-send debug (2 + 4)'"))

-- fullscreen
hl.bind("SUPER + F", dsp.window.fullscreen({ mode = "maximized" }))
hl.bind("SUPER + ALT + F", dsp.window.fullscreen())
hl.bind("SUPER + SHIFT + F", dsp.window.fullscreen_state({ internal = -1, client = 2 }))

for key, dir in pairs(dirs) do
	-- focus, falling back to plain focus when hy3 doesn't move it (e.g. across monitors)
	hl.bind("SUPER + " .. key, function()
		local before = active()
		if hl.plugin.hy3 then
			hl.dispatch(hl.plugin.hy3.move_focus(dir))
		end
		if active() == before then
			hl.dispatch(dsp.focus({ direction = dir }))
		end
	end)

	-- move
	hl.bind("SUPER + SHIFT + " .. key, hy3 and hy3.move_window(dir) or dsp.window.move({ direction = dir }))
end

-- relative windows
hl.bind("SUPER + BackSpace", dsp.window.cycle_next({ floating = true }))
hl.bind("SUPER + SHIFT + BackSpace", dsp.window.cycle_next({ floating = true, next = false }))

-- workspaces
local workspaces = {
	["1"] = 1, ["2"] = 2, ["3"] = 3, ["4"] = 4, ["5"] = 5,
	["6"] = 6, ["7"] = 7, ["8"] = 8, ["9"] = 9, ["0"] = 10,
	bracketright = 12,
	bracketleft = "name:lab",
	D = "name:meet",
	V = "name:void",
	W = "name:work",
}
for key, ws in pairs(workspaces) do
	hl.bind("SUPER + " .. key, dsp.focus({ workspace = ws }))
	hl.bind("SUPER + SHIFT + " .. key, dsp.window.move({ workspace = ws }))
end

for key, name in pairs({ I = "idk", M = "math", T = "term", S = "scratch", Y = "pasta" }) do
	hl.bind("SUPER + " .. key, dsp.workspace.toggle_special(name))
end
for key, name in pairs({ grave = "term", M = "math", S = "scratch", I = "idk", Y = "pasta" }) do
	hl.bind("SUPER + SHIFT + " .. key, dsp.window.move({ workspace = "special:" .. name }))
end

-- relative workspaces
hl.bind("SUPER + N", dsp.focus({ workspace = "m+1" }))
hl.bind("SUPER + C", dsp.focus({ workspace = "m+1" }))
hl.bind("SUPER + P", dsp.focus({ workspace = "m-1" }))
hl.bind("SUPER + G", dsp.focus({ workspace = "m-1" }))

-- prior
hl.bind("SUPER + escape", dsp.focus({ workspace = "previous" }))
hl.bind("SUPER + Tab", dsp.focus({ last = true }))
hl.bind("SUPER + apostrophe", dsp.focus({ urgent_or_last = true }))

-- relative monitors
hl.bind("SUPER + CTRL + H", dsp.focus({ monitor = "-1" }))
hl.bind("SUPER + CTRL + L", dsp.focus({ monitor = "+1" }))
hl.bind("SUPER + CTRL + SHIFT + H", dsp.workspace.move({ monitor = "-1" }))
hl.bind("SUPER + CTRL + SHIFT + L", dsp.workspace.move({ monitor = "+1" }))
hl.bind("SUPER + CTRL + ALT + H", dsp.workspace.swap_monitors({ monitor1 = "current", monitor2 = "-1" }))
hl.bind("SUPER + CTRL + ALT + L", dsp.workspace.swap_monitors({ monitor1 = "current", monitor2 = "+1" }))

-- nodes
if hy3 then
	hl.bind("SUPER + Z", hy3.change_focus("raise"))
	hl.bind("SUPER + SHIFT + Z", hy3.change_focus("lower"))
end

-- apps
hl.bind("SUPER + Return", exec(v.terminal))
hl.bind("SUPER + SHIFT + Return", exec(v.terminal .. " --class _float_"))
hl.bind("SUPER + E", exec(v.terminal .. [[ --class _float_ -- nu -l -c "edit-clip --focus | copy"]]))
hl.bind("SUPER + SHIFT + E", exec(v.terminal .. [[ --class _float_ -- nu -l -c "edit-clip --selection --type --focus"]]))
hl.bind("SUPER + O", exec(v.menu_app))
hl.bind("SUPER + SHIFT + O", exec(v.menu_run))

-- mouse
hl.bind("SUPER + mouse:272", dsp.window.drag(), { mouse = true })
hl.bind("SUPER + mouse:273", dsp.window.resize(), { mouse = true })

-- volume
hl.bind("SUPER + mouse_down", exec("~/bin/cfg volume +1"))
hl.bind("SUPER + mouse_up", exec("~/bin/cfg volume -1"))
hl.bind("SUPER + mouse:274", exec("~/bin/cfg volume !"))
hl.bind("SUPER + SHIFT + mouse_down", exec("~/bin/cfg volume +5"))
hl.bind("SUPER + SHIFT + mouse_up", exec("~/bin/cfg volume -5"))

hl.bind("XF86AudioLowerVolume", exec("~/bin/cfg volume -5"))
hl.bind("XF86AudioMicMute", exec("~/bin/cfg mic !"))
hl.bind("XF86AudioMute", exec("~/bin/cfg volume !"))
hl.bind("XF86AudioRaiseVolume", exec("~/bin/cfg volume +5"))
hl.bind("XF86MonBrightnessDown", exec("~/bin/cfg brightness -10"))
hl.bind("XF86MonBrightnessUp", exec("~/bin/cfg brightness +10"))

-- modes

hl.bind("SUPER + ALT + space", dsp.submap("MAIN"))
hl.define_submap("MAIN", function()
	hl.bind("space", dsp.submap("reset"))
	hl.bind("A", dsp.submap("APPS"))
	hl.bind("C", dsp.submap("COPYPASTA"))
	hl.bind("L", dsp.submap("LAYOUT"))
	hl.bind("M", dsp.submap("MOVE"))
	hl.bind("SHIFT + M", dsp.submap("META"))
	hl.bind("N", dsp.submap("NOTIFY"))
	hl.bind("R", dsp.submap("RESIZE"))
	hl.bind("S", dsp.submap("SYSTEM"))
	hl.bind("SHIFT + S", dsp.submap("SCREEN"))
	hl.bind("T", dsp.submap("TERMINAL"))
	hl.bind("SHIFT + T", dsp.submap("TAGS"))
	exits()
end)

hl.define_submap("META", "reset", function()
	hl.bind("B", exec("~/bin/bars"))
	exits()
end)

-- step sizes per modifier for RESIZE and MOVE
local steps = { ["ALT + "] = 10, [""] = 50, ["SHIFT + "] = 100, ["CTRL + "] = 400 }
local deltas = { h = { -1, 0 }, j = { 0, 1 }, k = { 0, -1 }, l = { 1, 0 } }
local function stepped(fn)
	for mod, n in pairs(steps) do
		for key, d in pairs(deltas) do
			hl.bind(mod .. key, fn({ x = d[1] * n, y = d[2] * n, relative = true }), { repeating = true })
		end
	end
end

hl.define_submap("RESIZE", function()
	stepped(dsp.window.resize)
	exits()
end)

hl.define_submap("MOVE", function()
	hl.bind("C", dsp.window.center())
	stepped(dsp.window.move)
	exits()
end)

hl.define_submap("NOTIFY", function()
	hl.bind("space", exec("makoctl menu"))
	hl.bind("A", exec("makoctl invoke"))
	hl.bind("C", once(exec("makoctl dismiss --all")))
	hl.bind("H", once(exec("makoctl history")))
	hl.bind("J", exec("makoctl restore"))
	hl.bind("K", exec("makoctl dismiss"))
	hl.bind("L", once(exec("makoctl list")))
	exits()
end)

hl.define_submap("LAYOUT", "reset", function()
	hl.bind("space", dsp.window.float())
	hl.bind("P", dsp.window.pin())
	if hy3 then
		hl.bind("T", hy3.change_group("toggletab"))
		hl.bind("H", hy3.make_group("h"))
		hl.bind("L", hy3.make_group("h"))
		hl.bind("V", hy3.make_group("v"))
		hl.bind("J", hy3.make_group("v"))
		hl.bind("K", hy3.make_group("v"))
		hl.bind("S", hy3.make_group("opposite"))
	end
	exits()
end)

hl.define_submap("APPS", "reset", function()
	hl.bind("space", exec(v.menu_app))
	hl.bind("A", exec(v.menu_all))
	hl.bind("C", exec("qalculate-qt"))
	hl.bind("R", exec(v.menu_run))
	hl.bind("S", exec("steam-native -console"))
	hl.bind("V", dsp.exec_cmd("pavucontrol", { float = true }))
	hl.bind("W", exec(v.menu_window))
	hl.bind("O", exec("obs"))
	hl.bind("Z", exec("zoom"))
	exits()
end)

hl.define_submap("COPYPASTA", "reset", function()
	hl.bind("space", exec("ringboard-egui"))
	hl.bind("C", exec([[nu -c "wlrctl keyboard type (wl-paste)"]]))
	hl.bind("E", exec("rofimoji --action=copy --skin-tone=neutral"))
	hl.bind("M", exec([[nu -c "cd ~/.password-store; ls **/* | where type == file | get name | str replace '.gpg' '' | to text | rofi -dmenu | pass -c \$in"]]))
	hl.bind("O", exec([[nu -c "hyprpicker -a"]]))
	hl.bind("P", exec([[nu -c "wlrctl keyboard type (wl-paste -p)"]]))
	hl.bind("U", exec([[nu -c "~/bin/dmenu-uni all"]]))
	exits()
end)

hl.define_submap("SYSTEM", function()
	hl.bind("J", exec("~/bin/cfg brightness -10"), { repeating = true })
	hl.bind("K", exec("~/bin/cfg brightness +10"), { repeating = true })
	hl.bind("L", once(exec("swaylock")))
	hl.bind("SHIFT + P", once(exec("loginctl poweroff")))
	hl.bind("SHIFT + R", once(exec("loginctl reboot")))
	hl.bind("SHIFT + S", once(exec("loginctl suspend")))
	-- delayed so the key release doesn't wake the monitors
	hl.bind("D", function()
		hl.dispatch(dsp.submap("reset"))
		hl.timer(function()
			hl.dispatch(dsp.dpms({ action = "disable" }))
		end, { timeout = 1000, type = "oneshot" })
	end)
	hl.bind("SHIFT + D", once(dsp.dpms({ action = "enable" })))
	exits()
end)

hl.define_submap("TERMINAL", "reset", function()
	hl.bind("space", exec("wezterm connect localhost"))
	hl.bind("B", exec("wezterm connect bork"))
	hl.bind("T", exec("wezterm connect tardis"))
	exits()
end)

hl.define_submap("TAGS", function()
	exits()
end)

hl.define_submap("SCREEN", "reset", function()
	hl.bind("space", exec("~/bin/screenshot select"))
	hl.bind("F", exec("~/bin/screenshot full"))
	hl.bind("S", exec("~/bin/screenshot screen"))
	hl.bind("W", exec("~/bin/screenshot window"))
	exits()
end)
