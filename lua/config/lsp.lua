-- Configure pylsp with native LSP config
vim.lsp.config.pylsp = {
	cmd = { "pylsp" },
	filetypes = { "python" },
	root_markers = { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", "Pipfile", ".git" },
	offset_encoding = "utf-8",
	on_init = function(client, config)
		-- Check for mypy configuration
		local has_mypy_config = false
		local root_dir = client.config.root_dir or vim.fn.getcwd()

		-- Check for mypy.ini or .mypy.ini
		if vim.fn.filereadable(root_dir .. "/mypy.ini") == 1 or vim.fn.filereadable(root_dir .. "/.mypy.ini") == 1 then
			has_mypy_config = true
		end

		-- Check for mypy in pyproject.toml
		if not has_mypy_config then
			local pyproject_path = root_dir .. "/pyproject.toml"
			if vim.fn.filereadable(pyproject_path) == 1 then
				local content = table.concat(vim.fn.readfile(pyproject_path), "\n")
				if content:match("%[tool%.mypy") then
					has_mypy_config = true
				end
			end
		end

		-- Update settings with mypy plugin if config found
		client.config.settings = client.config.settings or {}
		client.config.settings.pylsp = client.config.settings.pylsp or {}
		client.config.settings.pylsp.plugins = client.config.settings.pylsp.plugins or {}
		client.config.settings.pylsp.plugins.pylsp_mypy = { enabled = has_mypy_config }
	end,
	settings = {
		pylsp = {
			plugins = {
				pycodestyle = { enabled = false },
				pylsp_mypy = { enabled = false }, -- Will be dynamically set
			},
		},
	},
}

-- Configure ruff with native LSP config
vim.lsp.config.ruff = {
	cmd = { "ruff", "server" },
	filetypes = { "python" },
	root_markers = { "pyproject.toml", "ruff.toml", ".ruff.toml", ".git" },
	offset_encoding = "utf-8",
	on_attach = function(client, bufnr)
		client.server_capabilities.hoverProvider = false
	end,
	settings = {
		logLevel = "error",
		logFile = "/dev/null",
	},
}

-- Enable the LSP servers
vim.lsp.enable({ "pylsp", "ruff" })

-- Setup LSP keymaps
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		local opts = { buffer = ev.buf }
		vim.keymap.set(
			"n",
			"gD",
			vim.lsp.buf.declaration,
			vim.tbl_extend("force", opts, { desc = "Go to declaration" })
		)
		vim.keymap.set(
			"n",
			"gd",
			vim.lsp.buf.definition,
			vim.tbl_extend("force", opts, { desc = "Go to definition" })
		)
		vim.keymap.set(
			"n",
			"K",
			vim.lsp.buf.hover,
			vim.tbl_extend("force", opts, { desc = "Hover documentation" })
		)
		vim.keymap.set(
			"n",
			"gi",
			vim.lsp.buf.implementation,
			vim.tbl_extend("force", opts, { desc = "Go to implementation" })
		)
		vim.keymap.set(
			"n",
			"<C-k>",
			vim.lsp.buf.signature_help,
			vim.tbl_extend("force", opts, { desc = "Signature help" })
		)
		vim.keymap.set(
			"n",
			"<leader>rn",
			vim.lsp.buf.rename,
			vim.tbl_extend("force", opts, { desc = "Rename symbol" })
		)
		vim.keymap.set(
			{ "n", "v" },
			"<leader>ca",
			vim.lsp.buf.code_action,
			vim.tbl_extend("force", opts, { desc = "Code action" })
		)
		vim.keymap.set(
			"n",
			"gr",
			vim.lsp.buf.references,
			vim.tbl_extend("force", opts, { desc = "Go to references" })
		)
		vim.keymap.set(
			"n",
			"<leader>e",
			vim.diagnostic.open_float,
			vim.tbl_extend("force", opts, { desc = "Show line diagnostics" })
		)
	end,
})

return {}
