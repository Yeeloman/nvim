local lang_servers = {
  "lua_ls",
  "rust_analyzer",
  "bashls",
  "clangd",
  "ast_grep",
  "css_variables",
  "tailwindcss",
  "jinja_lsp",
  "docker_compose_language_service",
  "html",
  "ts_ls",
  "jsonls",
  "grammarly",
  "pylyzer",
  "pyright",
  "sqlls",
  "svelte",
  "yamlls",
  "efm",
  "harper_ls",
  "emmet_language_server",
}
return {

  {
    "neovim/nvim-lspconfig",
    config = function ()
      local lspconfig = require("lspconfig")

      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local servers = lang_servers

      for _, server in ipairs(servers) do
        if lspconfig[server] then
          lspconfig[server].setup({
            capabilities = capabilities,
          })
        end
      end

      vim.keymap.set('n', 'H', vim.lsp.buf.hover, { desc = "Show Def in Hover window" })
      vim.keymap.set('n', '<leader>gtd', vim.lsp.buf.definition, { desc = "Go to definition" })
      vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = "Code Action" })
    end
  },
  {
    "williamboman/mason.nvim",
    config = function ()
      require("mason").setup({})
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {

      "neovim/nvim-lspconfig",
      "williamboman/mason.nvim",
    },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = lang_servers,
      })
    end,
  }
}

