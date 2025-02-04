local M = {}
local cnv = require('colorCnv')

function M.read_wal_colors()
    local colors = {}
    local seen = {}
    local color_file = os.getenv("HOME") .. "/.cache/wal/colors"

    local file = io.open(color_file, "r")
    if file then
        for line in file:lines() do
            if not seen[line] then
                table.insert(colors, line)
                seen[line] = true
            end
        end
        file:close()
    end

    return colors
end

local function apply_golden_ratio(hex)
    local phi = 1.6180339887
    local hue_step = 360 / phi

    -- Convert HEX to LCH
    local l, c, h = cnv.hex2lch(hex)

    -- Apply golden ratio hue rotation
    h = (h + hue_step) % 360

    -- Convert back to HEX
    return cnv.lch2hex(l, c, h)
end

function M.generate_palette(base_colors, total_colors)
    local palette = {}

    for i = 1, total_colors do
        local base_hex = base_colors[(i - 1) % #base_colors + 1]
        local new_hex = apply_golden_ratio(base_hex)
        table.insert(palette, new_hex)
    end

    return palette
end

return M
