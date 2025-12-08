-- These are the basic's for using wezterm.
-- Mux is the mutliplexes for windows etc inside of the terminal
-- Action is to perform actions on the terminal
local wezterm = require("wezterm")
local mux = wezterm.mux
local act = wezterm.action

-- These are vars to put things in later (i dont use em all yet)
local config = {}
local keys = {}
local mouse_bindings = {}
local launch_menu = {}

-- This is for newer wezterm vertions to use the config builder
if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- Default config settings
-- These are the default config settins needed to use Wezterm
-- Just add this and return config and that's all the basics you need

-- Color scheme, Wezterm has 100s of them you can see here:
-- https://wezfurlong.org/wezterm/colorschemes/index.html
config.color_scheme = "Catppuccin Mocha"
-- This is my chosen font, we will get into installing fonts on windows later
config.font = wezterm.font("ComicShannsMono Nerd Font Mono")
config.font_size = 11
config.launch_menu = launch_menu
-- makes my cursor blink
config.default_cursor_style = "BlinkingBar"
-- config.disable_default_key_bindings = true
-- this adds the ability to use ctrl+v to paste the system clipboard
config.keys = {
	{
		key = "v",
		mods = "CTRL",
		action = act.PasteFrom("Clipboard"),
	},
	{ key = "=", mods = "CTRL", action = wezterm.action.IncreaseFontSize },
	{ key = "-", mods = "CTRL", action = wezterm.action.DecreaseFontSize },
	{ key = "Tab", mods = "CTRL", action = act.ActivateTabRelative(1) },
	{ key = "Tab", mods = "CTRL|SHIFT", action = act.ActivateTabRelative(-1) },
	{ key = "t", mods = "CTRL|SHIFT", action = act.SpawnTab("CurrentPaneDomain") },
}

-- There are mouse binding to mimc Windows Terminal and let you copy
-- To copy just highlight something and right click. Simple
mouse_bindings = {
	{
		event = { Down = { streak = 3, button = "Left" } },
		action = wezterm.action.SelectTextAtMouseCursor("SemanticZone"),
		mods = "NONE",
	},
	{
		event = { Down = { streak = 1, button = "Right" } },
		mods = "NONE",
		action = wezterm.action_callback(function(window, pane)
			local has_selection = window:get_selection_text_for_pane(pane) ~= ""
			if has_selection then
				window:perform_action(act.CopyTo("ClipboardAndPrimarySelection"), pane)
				window:perform_action(act.ClearSelection, pane)
			else
				window:perform_action(act({ PasteFrom = "Clipboard" }), pane)
			end
		end),
	},
	-- Bind 'Up' event of CTRL-Click to open hyperlinks
	{
		event = { Up = { streak = 1, button = "Left" } },
		mods = "CTRL",
		action = act.OpenLinkAtMouseCursor,
	},
	-- Disable the 'Down' event of CTRL-Click to avoid weird program behaviors
	{
		event = { Down = { streak = 1, button = "Left" } },
		mods = "CTRL",
		action = act.Nop,
	},
	-- Scrolling up while holding CTRL increases the font size
	{
		event = { Down = { streak = 1, button = { WheelUp = 1 } } },
		mods = "CTRL",
		action = act.IncreaseFontSize,
	},

	-- Scrolling down while holding CTRL decreases the font size
	{
		event = { Down = { streak = 1, button = { WheelDown = 1 } } },
		mods = "CTRL",
		action = act.DecreaseFontSize,
	},
}

config.mouse_bindings = mouse_bindings
-- This is used to make my foreground (text, etc) brighter than my background
config.foreground_text_hsb = {
	hue = 1.0,
	saturation = 1.2,
	brightness = 1.5,
}

-- This is used to set an image as my background

-- IMPORTANT: Sets WSL2 UBUNTU-22.04 as the defualt when opening Wezterm
local wsl_domains = wezterm.default_wsl_domains()

for _, dom in ipairs(wsl_domains) do
	dom.default_cwd = "/home/sai"
end
config.default_domain = "WSL:Ubuntu"
config.default_cwd = "/home/sai"
config.wsl_domains = wsl_domains
config.window_decorations = "RESIZE"

return config
