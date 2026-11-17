hl.config({
	general = {
		layout = hl.plugin.hy3 and "hy3" or "dwindle",

		gaps_in = 0,
		gaps_out = 0,

		border_size = 2,

		col = {
			active_border   = { colors = {"rgba(33ccffee)", "rgba(00ff99ee)"}, angle = 45 },
			inactive_border = "rgba(595959aa)",
		},
	},

	input = {
		follow_mouse = 2,
		numlock_by_default = true,
	},

	binds = {
		allow_workspace_cycles = true,
		scroll_event_delay = 0,
		workspace_back_and_forth = true,
	},

	cursor = {
		no_warps = true,
		default_monitor = "DP-1",
	},

	debug = {
		disable_logs = true,
		-- TEMP
		suppress_errors = true,
	},

	misc = {
		key_press_enables_dpms = true,
		mouse_move_focuses_monitor = false,
		on_focus_under_fullscreen = 2,
		vrr = 1,
	},

	dwindle = {
		smart_split = true,
	},

	decoration = {
		rounding = 4,
		rounding_power = 2,
	},

	animations = {
		enabled = true,
	},
})

if hl.plugin.hyprbars then
	hl.config({
		plugin = {
			hyprbars = {
				bar_height = 16,
				bar_color = "rgb(815ba4)",
				bar_text_size = 12,
			},
		},
	})

	for _, b in ipairs({
		{ "rgb(ff4040)", "󰖭", [[hl.dsp.window.close()]] },
		{ "rgb(eeee11)", "", [[hl.dsp.window.fullscreen({ mode = "maximized" })]] },
		{ "rgb(004040)", "↗️", [[hl.dsp.window.fullscreen_state({ internal = -1, client = 2 })]] },
		{ "rgb(004040)", "🎈", [[hl.dsp.window.float()]] },
		{ "rgb(004040)", "🪡", [[hl.dsp.window.pin()]] },
		{ "rgb(eeee11)", "➡️", [[hl.plugin.hy3.make_group("h")]] },
		{ "rgb(eeee11)", "⬇️", [[hl.plugin.hy3.make_group("v")]] },
	}) do
		hl.plugin.hyprbars.add_button({
			bg_color = b[1],
			fg_color = "rgb(ffffff)",
			size = 16,
			icon = b[2],
			action = "hyprctl dispatch '" .. b[3] .. "'",
		})
	end
end
