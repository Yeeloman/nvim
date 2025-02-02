local M = {}

local function luminance(color)
  local r, g, b = color:match("#(%x%x)(%x%x)(%x%x)")
  r, g, b = tonumber(r, 16) / 255, tonumber(g, 16) / 255, tonumber(b, 16) / 255
  return 0.2126 * r + 0.7152 * g + 0.0722 * b
end

local function adjust_color(color, factor)
  local r, g, b = color:match("#(%x%x)(%x%x)(%x%x)")
  r, g, b = tonumber(r, 16), tonumber(g, 16), tonumber(b, 16)

  r = math.min(math.max(r * factor, 0), 255)
  g = math.min(math.max(g * factor, 0), 255)
  b = math.min(math.max(b * factor, 0), 255)

  return string.format("#%02x%02x%02x", r, g, b)
end

function M.ensure_contrast(color, bg_color)
  local contrast = math.abs(luminance(color) - luminance(bg_color))
  if contrast < 0.3 then
    return adjust_color(color, 1.2)
  end
  return color
end

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

function M.generate_variants(colors, total_colors)
  local new_colors = {}
  local num_existing = #colors
  if num_existing >= total_colors then
    return { table.unpack(colors, 1, total_colors) }
  end

  local index = 1
  while #new_colors < total_colors do
    local factor = 0.9 + ((#new_colors % num_existing) * 0.2 / num_existing)
    table.insert(new_colors, adjust_color(colors[index], factor))
    index = (index % num_existing) + 1
  end

  return new_colors
end

return M
