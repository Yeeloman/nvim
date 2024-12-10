return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",   -- LSP source for nvim-cmp
    "hrsh7th/cmp-buffer",     -- Buffer completions
    "hrsh7th/cmp-path",       -- Path completions
    "hrsh7th/cmp-cmdline",    -- Command-line completions
    "L3MON4D3/LuaSnip",       -- Snippet engine
    "saadparwaiz1/cmp_luasnip", -- Snippet completions
  },
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")

    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = {
        ["<C-b>"] = cmp.mapping.scroll_docs(-1),
        ["<C-f>"] = cmp.mapping.scroll_docs(1),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
      },
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
      }, {
          { name = "buffer" },
          { name = "path" },
        }),
    })

    -- Set up `/` and `:` command-line completions
    cmp.setup.cmdline("/", {
      sources = {
        { name = "buffer" },
      },
    })

    cmp.setup.cmdline(":", {
      sources = cmp.config.sources({
        { name = "path" },
      }, {
          { name = "cmdline" },
        }),
    })
  end,
}

