return {
  "nvim-treesitter/nvim-treesitter",
  config = function()
    require('nvim-treesitter.configs').setup({
      ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline", "python", "rust", "html", "javascript", "typescript", "css", "svelte", "bash", "json", "yaml" },
      auto_install = true,
      highlight = {
        enable = true,
      }
    })
  end,
}
