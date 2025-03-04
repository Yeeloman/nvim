local keymap = vim.keymap

-- Language servers
local lang_servers = {
	"lua_ls",
	"rust_analyzer",
	"bashls",
	"clangd",
	"css_variables",
	"jinja_lsp",
	"docker_compose_language_service",
	"ts_ls",
	"jsonls",
	"grammarly",
	"sqlls",
	"svelte",
	"yamlls",
	"efm",
	"emmet_language_server",
	"pyright",
	"tailwindcss",
	"marksman",
}

-- Function to set LSP keybindings
local function set_lsp_keymaps()
	keymap.set("n", "H", vim.lsp.buf.hover, { desc = "Show Def in Hover window" })
	keymap.set("n", "<leader>gtD", vim.lsp.buf.definition, { desc = "Go to definition" })
	keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })
	keymap.set("n", "<leader>gf", vim.lsp.buf.format, { desc = "Format the current file" })
end

return {
	-- Mason for managing LSP servers
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup({})
		end,
	},

	-- Mason-LSPConfig for handling server installations
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "neovim/nvim-lspconfig", "williamboman/mason.nvim" },
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = lang_servers
			})
		end,
	},

	-- None-ls for handling formatters
	{
		"nvimtools/none-ls.nvim",
		config = function()
			local null_ls = require("null-ls")

			null_ls.setup({
				sources = {
					null_ls.builtins.formatting.prettier.with({
						filetypes = { "html", "htmldjango" },
					}),
					null_ls.builtins.formatting.djlint.with({
						filetypes = { "htmldjango" },
					}),
				},
			})
		end,
	},
	-- Null-LS (for formatters & linters)
	{
		"jay-babu/mason-null-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = { "williamboman/mason.nvim", "nvimtools/none-ls.nvim" },
		config = function()
			require("mason-null-ls").setup({
				ensure_installed = {
					"stylua",
					"prettier",
					"black",
					"djlint",
					"isort",
					"eslint_d",
				}
			})
		end,
	},

	-- LSPConfig for configuring language servers
	{
		"neovim/nvim-lspconfig",
		config = function()
			local lspconfig = require("lspconfig")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			-- capabilities.workspace = { didChangeWatchedFiles = { dynamicRegistration = true } }

			-- Define auto-formatting on save
			local function on_attach(client, bufnr)
				if client.server_capabilities.documentFormattingProvider then
					vim.api.nvim_create_autocmd("BufWritePre", {
						buffer = bufnr,
						callback = function()
							vim.lsp.buf.format()
						end,
					})
				end
			end

			-- Explicit configurations
			local servers = {
				pyright = {
					settings = {
						python = {
							analysis = {
								autoSearchPaths = true,
								useLibraryCodeForTypes = true,
								diagnosticMode = "workspace",
								stubPath = vim.fn.stdpath("data") .. "/mason/packages/python-type-stubs",
							}
						}
					}
				},
			}

			-- Register special servers with specific settings
			for server, config in pairs(servers) do
				config.capabilities = capabilities
				config.on_attach = on_attach
				lspconfig[server].setup(config)
			end

			-- Register all other general language servers dynamically
			for _, server in ipairs(lang_servers) do
				if not servers[server] then
					lspconfig[server].setup({ capabilities = capabilities, on_attach = on_attach })
				end
			end

			-- Apply keybindings
			set_lsp_keymaps()
		end,
	},
}
