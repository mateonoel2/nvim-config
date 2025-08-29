return {
	"dstein64/nvim-scrollview",
	dependencies = { "lewis6991/gitsigns.nvim" },
	config = function()
		require("scrollview").setup({
			signs_on_startup = { "all" },
			diagnostics_severities = {
				vim.diagnostic.severity.ERROR,
				vim.diagnostic.severity.WARN,
			},
		})

		-- Enable gitsigns integration
		require("scrollview.contrib.gitsigns").setup()
	end,
}
