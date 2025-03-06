local M = {}

-- Require the shared PaletteGen module to read colors
local pg = require("shared.PaletteGen")
local colors = pg.colors_to_strings(pg.read_wal_colors())

-- Define a table to store the highlight colors for each mode
M.mode_highlights = {
	n = colors[6],     -- Normal mode
	i = colors[2],     -- Insert mode
	v = colors[9],     -- Visual mode
	V = colors[9],     -- Visual Line mode
	['^V'] = colors[9], -- Visual Block mode
	c = colors[3],     -- Command-line mode
	t = colors[4],     -- Terminal mode
}

-- Function to calculate a contrasting foreground color
local function get_contrasting_color(background_color)
	-- Convert the hex color to RGB
	local r, g, b = background_color:match("#(%x%x)(%x%x)(%x%x)")
	r = tonumber(r, 16)
	g = tonumber(g, 16)
	b = tonumber(b, 16)

	-- Calculate luminance (perceived brightness)
	local luminance = (0.299 * r + 0.587 * g + 0.114 * b) / 255

	-- Return black or white based on luminance
	if luminance > 0.5 then
		return "#000000" -- Black for light backgrounds
	else
		return "#ffffff" -- White for dark backgrounds
	end
end

-- Function to highlight the line number background based on the mode
function M.highlight_line_numbers()
	local mode = vim.fn.mode()
	local bg_color = M.mode_highlights[mode] or
			"#1c1c1c" -- Fallback to a default color if mode is unknown
	local fg_color = get_contrasting_color(bg_color)
	-- vim.cmd("hi CursorLineNr guibg=" .. color .. " guifg='#cdd6f4' gui=bold,italic") -- Change the background color of line numbers
	vim.cmd(string.format(
		"hi CursorLineNr guibg=%s guifg=%s gui=bold,italic",
		bg_color,
		fg_color
	))
end

-- Function to set up the autocmd group for mode-based line number highlighting
function M.setup()
	vim.cmd([[
      augroup ModeLineNrHighlight
        autocmd!
        autocmd ModeChanged *:[vV\x16] lua require('config.modules.mode_line_nr_highlight').highlight_line_numbers()  -- Trigger when entering Visual mode
        autocmd ModeChanged [vV\x16]:* lua require('config.modules.mode_line_nr_highlight').highlight_line_numbers()  -- Trigger when leaving Visual mode
        autocmd ModeChanged *:i lua require('config.modules.mode_line_nr_highlight').highlight_line_numbers()  -- Trigger when entering Insert mode
        autocmd ModeChanged i:* lua require('config.modules.mode_line_nr_highlight').highlight_line_numbers()  -- Trigger when leaving Insert mode
        autocmd ModeChanged *:n lua require('config.modules.mode_line_nr_highlight').highlight_line_numbers()  -- Trigger when entering Normal mode
        autocmd ModeChanged *:c lua require('config.modules.mode_line_nr_highlight').highlight_line_numbers()  -- Trigger when entering Command-line mode
        autocmd ModeChanged c:* lua require('config.modules.mode_line_nr_highlight').highlight_line_numbers()  -- Trigger when leaving Command-line mode
        autocmd ModeChanged *:t lua require('config.modules.mode_line_nr_highlight').highlight_line_numbers()  -- Trigger when entering Terminal mode
      augroup END
    ]])
end

-- local function blink_highlight()
-- 	local blink = true
-- 	vim.loop.new_timer():start(0, 500, vim.schedule_wrap(function()
-- 		if blink then
-- 			vim.cmd("hi CursorLineNr guibg=#ff0000 guifg=#ffffff gui=bold")
-- 		else
-- 			vim.cmd("hi CursorLineNr guibg=#0000ff guifg=#ffffff gui=bold")
-- 		end
-- 		blink = not blink
-- 	end))
-- end
--
-- -- Start the blinking effect
-- blink_highlight()

return M
