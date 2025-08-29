return {
	"lewis6991/gitsigns.nvim",
	opts = {
		signs = {
			add = { text = "+" },
			change = { text = "~" },
			delete = { text = "-" },
			topdelete = { text = "‾" },
			changedelete = { text = "~" },
		},
		signcolumn = true,
		current_line_blame = true,
		current_line_blame_opts = {
			virt_text = true,
			virt_text_pos = "eol",
			delay = 100,
		},
		on_attach = function(bufnr)
			local gitsigns = require("gitsigns")

			-- Toggle between HEAD and remote default branch as base
			local base_state = "HEAD" -- Track state manually
			local function toggle_gitsigns_base()
				if base_state == "HEAD" then
					-- Get the default branch name from remote
					local default_branch = vim.fn
						.system('git remote show origin | grep "HEAD branch" | cut -d: -f2 | xargs')
						:gsub("\n", "")
					if default_branch == "" then
						-- Fallback: check what origin/HEAD points to
						local head_ref = vim.fn
							.system("git symbolic-ref refs/remotes/origin/HEAD 2>/dev/null")
							:gsub("\n", "")
							:gsub("refs/remotes/origin/", "")
						if head_ref ~= "" then
							default_branch = head_ref
						else
							-- Last resort: assume main
							default_branch = "main"
						end
					end

					-- Temporarily disable blame when using remote base
					gitsigns.toggle_current_line_blame(false)
					gitsigns.change_base("origin/" .. default_branch)
					base_state = "origin/" .. default_branch
					print("Gitsigns base: origin/" .. default_branch)
				else
					gitsigns.change_base(nil) -- Reset to default (HEAD)
					gitsigns.toggle_current_line_blame(true) -- Re-enable blame
					base_state = "HEAD"
					print("Gitsigns base: HEAD")
				end
			end

			-- Add keybindings
			vim.keymap.set("n", "<leader>gb", toggle_gitsigns_base, {
				buffer = bufnr,
				desc = "Toggle gitsigns base between HEAD and remote default",
			})
			vim.keymap.set(
				"n",
				"<leader>hp",
				"<cmd>Gitsigns preview_hunk<cr>",
				{ buffer = bufnr, desc = "Preview hunk" }
			)
			vim.keymap.set(
				"n",
				"<leader>hd",
				"<cmd>Gitsigns toggle_deleted<cr>",
				{ buffer = bufnr, desc = "Toggle deleted lines" }
			)
			vim.keymap.set("n", "]h", "<cmd>Gitsigns next_hunk<cr>", { buffer = bufnr, desc = "Next hunk" })
			vim.keymap.set("n", "[h", "<cmd>Gitsigns prev_hunk<cr>", { buffer = bufnr, desc = "Previous hunk" })
		end,
	},
}
