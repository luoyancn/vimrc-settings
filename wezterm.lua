local wezterm = require 'wezterm'

return {
        default_prog = {'wsl.exe', '--cd', '~', '--distribution', 'f36'},
        window_decorations = 'RESIZE',
        font = wezterm.font('CodeNewRoman Nerd Font', { weight = 'Regular' }),
        font_size = 14,
        --line_height = 1.2,
        allow_square_glyphs_to_overflow_width = 'Always',
        harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' },
        adjust_window_size_when_changing_font_size = false,
        freetype_load_flags = 'NO_HINTING',
        freetype_render_target = 'Normal',
        window_background_image = 'C:\\Windows\\Web\\Wallpaper\\Anime\\100299297_p0.jpg',
        window_background_image_hsb = {
                brightness = 0.05,
                hue = 1.0,
                saturation = 1.0,
        },
        enable_wayland = false,
        --window_background_opacity = 0.45,
        wezterm.on('gui-startup', function(cmd)
                local mux = wezterm.mux
                local tab, pane, window = mux.spawn_window(cmd or {})
                window:gui_window():maximize()
        end),

        keys = {
                -- 水平分屏（上下）
                {
                        key = 'h',
                        mods = 'CTRL|SHIFT',
                        action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
                },
                -- 垂直分屏（左右）
                {
                        key = 'j',
                        mods = 'CTRL|SHIFT',
                        action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
                },
                -- 面板间导航
                {
                        key = 'h',
                        mods = 'ALT',
                        action = wezterm.action.ActivatePaneDirection 'Left',
                },
                {
                        key = 'l',
                        mods = 'ALT',
                        action = wezterm.action.ActivatePaneDirection 'Right',
                },
                {
                        key = 'k',
                        mods = 'ALT',
                        action = wezterm.action.ActivatePaneDirection 'Up',
                },
                {
                        key = 'j',
                        mods = 'ALT',
                        action = wezterm.action.ActivatePaneDirection 'Down',
                },
                --tab切换
                {
                        key = '1',
                        mods = 'ALT',
                        action = wezterm.action.ActivateTab(0),
                },
                {
                        key = '2',
                        mods = 'ALT',
                        action = wezterm.action.ActivateTab(1),
                },
                {
                        key = '3',
                        mods = 'ALT',
                        action = wezterm.action.ActivateTab(2),
                },
                {
                        key = '4',
                        mods = 'ALT',
                        action = wezterm.action.ActivateTab(3),
                },
                {
                        key = '5',
                        mods = 'ALT',
                        action = wezterm.action.ActivateTab(4),
                },
                {
                        key = '6',
                        mods = 'ALT',
                        action = wezterm.action.ActivateTab(5),
                },
                {
                        key = '7',
                        mods = 'ALT',
                        action = wezterm.action.ActivateTab(6),
                },
                {
                        key = '8',
                        mods = 'ALT',
                        action = wezterm.action.ActivateTab(7),
                },
                {
                        key = '9',
                        mods = 'ALT',
                        action = wezterm.action.ActivateTab(8),
                },
        },
        colors = {
                foreground = '#fce8c3',
                background = '#1c1b19',
                cursor_bg = '#fce8c3',
                cursor_border = '#fce8c3',
                cursor_fg = '#1c1b19',
                selection_bg = '#fce8c3',
                selection_fg = '#1c1b19',
                ansi = {
                        '#1c1b19', -- black
                        '#ef2f27', -- red
                        '#519f50', -- green
                        '#fbb829', -- yellow
                        '#2c78bf', -- blue
                        '#e02c6d', -- magenta
                        '#0aaeb3', -- cyan
                        '#baa67f', -- white
                },
                brights = {
                        '#918175', -- bright black
                        '#f75341', -- bright red
                        '#98bc37', -- bright green
                        '#fed06e', -- bright yellow
                        '#68a8e4', -- bright blue
                        '#ff5c8f', -- bright magenta
                        '#53fde9', -- bright cyan
                        '#fce8c3', -- bright white
                },
        }
}
