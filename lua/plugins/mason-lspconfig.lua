return {
  "williamboman/mason-lspconfig.nvim",
  dependencies = {
    { -- Define each dependency as a separate table for clarity
      "neovim/nvim-lspconfig",
    },
    {
      "williamboman/mason.nvim",
      config = function()
        require("mason").setup()
      end,
    },
  },
  config = function()
    require("mason-lspconfig").setup()
    require("mason-lspconfig").setup_handlers({
      function(server_name)
        require("lspconfig")[server_name].setup({})
      end,
    })
  end,
}

