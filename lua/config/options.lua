-- Basic vim options
vim.opt.clipboard = "unnamedplus" -- Use system clipboard for yank/paste
vim.opt.number = true -- Show line numbers
vim.opt.relativenumber = true -- Show relative line numbers

-- Auto-toggle relative numbers based on mode
vim.api.nvim_create_autocmd({ "InsertEnter" }, {
	callback = function()
		vim.opt.relativenumber = false
	end,
})

vim.api.nvim_create_autocmd({ "InsertLeave" }, {
	callback = function()
		vim.opt.relativenumber = true
	end,
})

vim.opt.tabstop = 2 -- Tab width
vim.opt.shiftwidth = 2 -- Indent width
vim.opt.expandtab = true -- Use spaces instead of tabs
vim.opt.smartindent = true -- Smart indentation
vim.opt.wrap = false -- Don't wrap lines
vim.opt.swapfile = false -- Disable swap files
vim.opt.backup = false -- Disable backup files
vim.opt.undofile = true -- Enable persistent undo
vim.opt.incsearch = true -- Incremental search
vim.opt.termguicolors = true -- Enable 24-bit colors
vim.opt.signcolumn = "yes" -- Always show sign column
vim.opt.updatetime = 50 -- Faster completion

-- Enable completion
vim.opt.completeopt = { "menu", "menuone", "noselect" }
