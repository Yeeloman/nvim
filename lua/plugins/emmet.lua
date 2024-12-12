return {
  "mattn/emmet-vim",
  event = "VeryLazy",
  config = function ()
    vim.g.user_emmet_install_global = 0
    vim.api.nvim_create_autocmd("FileType", {
      pattern = {"html", "css"},
      callback = function()
        vim.cmd("EmmetInstall")
      end
    })
  end
}

