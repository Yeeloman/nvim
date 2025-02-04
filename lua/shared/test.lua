local M = require('PaletteGen')  -- Replace with the actual module name if different

-- Example base colors (can be customized)
local base_colors = {'#FF5733', '#33FF57', '#5733FF'}

-- Total colors to generate in the palette
local total_colors = 10

-- Generate the color palette
local palette = M.generate_palette(base_colors, total_colors)

-- Open a file for writing the color palette
local file = io.open('color_palette.txt', 'w')

-- Check if the file was successfully opened
if not file then
    print("Error: Unable to open file for writing.")
    return
end

-- Write each color to the file, one color per line
for _, color in ipairs(palette) do
    file:write(color .. '\n')
end

-- Close the file
file:close()

print("Color palette has been written to color_palette.txt")
