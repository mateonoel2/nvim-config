return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	cmd = { "ConformInfo" },
	keys = {
		{
			"<leader>F",
			function()
				require("conform").format({ async = true, lsp_fallback = true })
			end,
			mode = "",
			desc = "Format buffer",
		},
	},
	opts = {
		formatters_by_ft = {
			python = { "ruff_format", "ruff_organize_imports" },
			lua = { "stylua" },
      go = {"gofumpt"},
			javascript = function(bufnr)
				local clients = vim.lsp.get_clients({ bufnr = bufnr, name = "biome" })
				return #clients > 0 and { "biome" } or { "prettier" }
			end,
			javascriptreact = function(bufnr)
				local clients = vim.lsp.get_clients({ bufnr = bufnr, name = "biome" })
				return #clients > 0 and { "biome" } or { "prettier" }
			end,
			typescript = function(bufnr)
				local clients = vim.lsp.get_clients({ bufnr = bufnr, name = "biome" })
				return #clients > 0 and { "biome" } or { "prettier" }
			end,
			typescriptreact = function(bufnr)
				local clients = vim.lsp.get_clients({ bufnr = bufnr, name = "biome" })
				return #clients > 0 and { "biome" } or { "prettier" }
			end,
			json = function(bufnr)
				local clients = vim.lsp.get_clients({ bufnr = bufnr, name = "biome" })
				return #clients > 0 and { "biome" } or { "prettier" }
			end,
			css = { "prettier" },
			html = { "prettier" },
			markdown = { "prettier" },
		},
		formatters = {
			stylua = { prepend_args = { "--column-width", "100" } },
		},
	},
}
