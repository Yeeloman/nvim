-- for more informations check
-- https://github.com/mbbill/undotree
local keymap = vim.keymap
return {
  "mbbill/undotree",
  config = function()
    -- add undo tree
    keymap.set('n', '<leader><F5>', vim.cmd.UndotreeToggle, {desc = "Open undo tree"})
  end,

}
