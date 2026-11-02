hl.on("hyprland.start", function()
	hl.exec_cmd("hyprpm reload -n")
	hl.exec_cmd("hyprpaper")
	hl.exec_cmd("dbus-update-activation-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")

	-- hl.exec_cmd("godot --path ~/dev/games/ref/gdext-v-demos/beeg", { workspace = "1" })
	-- hl.exec_cmd("foot --app-id beeg -o colors.alpha=0.0 -o pad=0x28 -- cava", { workspace = "2" })

	-- hl.exec_cmd("eww daemon")
	-- hl.exec_cmd([[nu -l -c "bars"]])
end)
