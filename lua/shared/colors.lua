local M = {}

function M.read_wal_colors()
  local colors = {}
  local color_file = os.getenv("HOME") .. "/.cache/wal/colors"

  -- Try to read from the colors file first
  local file = io.open(color_file, "r")
  if file then
    for line in file:lines() do
      table.insert(colors, line)
    end
    file:close()
  end

  return colors
end

return M

