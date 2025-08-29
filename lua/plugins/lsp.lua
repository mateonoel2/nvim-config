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

return {}
