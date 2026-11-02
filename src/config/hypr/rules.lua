local v = require("vars")

-- workspaces

for id, name in pairs({
	[1] = "browse", [2] = "dev", [3] = "design", [4] = "hack", [5] = "write",
	[6] = "watch", [7] = "listen", [8] = "heed", [9] = "view", [10] = "chat", [12] = "play",
}) do
	hl.workspace_rule({ workspace = tostring(id), default_name = name })
end

-- spawned when a workspace is created empty, keyed by id or name
local spawn = {
	[4] = { v.terminal .. " --cwd ~/dotfiles" },
	[5] = { "obsidian" },
	[7] = { "gtk-launch ytmusic" },
	[9] = { v.terminal .. " yazi" },
	[12] = { "steam-native -console" },
	["meet"] = { "gtk-launch teams-for-linux" },
	["special:term"] = { v.terminal .. " --class quake --cwd /tmp/ciea", { float = true } },
	["special:math"] = { "qalculate-qt", { float = true } },
	["special:pasta"] = { "ringboard-egui", { float = true } },
	["special:scratch"] = { "heynote", { float = true } },
}

hl.on("workspace.created", function(ws)
	local s = spawn[ws.id] or spawn[ws.name]
	if s and ws.is_empty then
		hl.exec_cmd(s[1], s[2])
	end
end)

hl.window_rule({
	name = "ws-slack",
	match = { class = "slack" },
	workspace = "10",
})

-- generic

hl.window_rule({
	name = "generic-float-title",
	match = { title = "^(.*_float_.*)$" },
	float = true,
})

hl.window_rule({
	name = "generic-float-class",
	match = { class = "^(.*_float_.*)$" },
	float = true,
})

-- apps

hl.window_rule({
	name = "ringboard",
	match = { class = "ringboard-egui" },
	float = true,
})

hl.window_rule({
	name = "zoom",
	match = { class = "^(Zoom.*)$", title = "^(zoom|menu window)$" },
	float = true,
})

hl.window_rule({
	name = "godot",
	match = { class = [[^(org\.godotengine\.Editor)$]], initial_title = "negative:^(Godot)$" },
	float = true,
})

hl.window_rule({
	name = "volume",
	match = { class = "org.pulseaudio.pavucontrol", title = "^Volume Control$" },
	float = true,
	pin = true,
})

for name, class in pairs({ quake = "^(quake)$", float = "^(_float_)$" }) do
	hl.window_rule({
		name = name,
		match = { class = class },
		float = true,
		center = true,
		opacity = "0.75 override 0.75 override",
		animation = "slidefade",
		size = { 1920, 1080 },
	})
end
