return {
	menu_all = "rofi -drun-show-actions -combi-modi drun,run -show combi",
	-- menu_app = "hyprlauncher",
	menu_app = "rofi -drun-show-actions -show drun -display-drun launch",
	menu_run = "rofi -drun-show-actions -show run -sidebar-mode",
	menu_window = "rofi -drun-show-actions -show window -sidebar-mode",
	-- menu_window = "hyprctl clients -j | from json | each { $'($in.address): ($in.title)' } | to text | hyprlauncher -m",
	terminal = "wezterm start",
}
