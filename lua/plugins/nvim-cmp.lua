return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",     -- LSP source for nvim-cmp
    "hrsh7th/cmp-buffer",       -- Buffer completions
    "hrsh7th/cmp-path",         -- Path completions
    "hrsh7th/cmp-cmdline",      -- Command-line completions
    "L3MON4D3/LuaSnip",         -- Snippet engine
    "saadparwaiz1/cmp_luasnip", -- Snippet completions
    "rafamadriz/friendly-snippets",
  },
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")

    require("luasnip.loaders.from_vscode").lazy_load()

    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      window = {
        completion = cmp.config.window.bordered({
          border = "rounded", -- Border style
          winblend = 10,      -- Transparency (0-100)
          col_offset = 5,     -- Horizontal offset
          side_padding = 2,   -- Padding inside the menu
        }),
        documentation = cmp.config.window.bordered({
          border = "rounded", -- Border style
          winblend = 10,      -- Transparency (0-100)
        }),
      },
      mapping = {
        -- Scroll through the suggestion popup menu
        ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),

        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
      },
      sources = cmp.config.sources({
        { name = "luasnip" },
        { name = "nvim_lsp" },
        { name = "buffer" },
        { name = "path" },
        { name = "nvim_lua" },
      }),
      -- Formatting the completion items
      -- formatting = {
      --   format = function(entry, vim_item)
      --     -- Customize the appearance of each item in the menu
      --     vim_item.menu = ({
      --       nvim_lsp = "[LSP]",
      --       vsnip = "[Snippet]",
      --       buffer = "[Buffer]",
      --       path = "[Path]",
      --       cmdline = "[Cmdline]",         -- Add this for command-line completion
      --       cmdline_history = "[History]", -- Add this for command-line history completion
      --     })[entry.source.name]
      --     return vim_item
      --   end,
      -- },
      experimental = {
        ghost_text = true, -- Show ghost text for the selected item
      },
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
        { name = "cmdline" },
      }),
    })
  end,
}
