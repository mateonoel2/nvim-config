return {
  "sindrets/diffview.nvim",
  cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
  keys = {
    { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Git Diff View" },
    { "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", desc = "Git File History" },
    { "<leader>gc", "<cmd>DiffviewClose<cr>", desc = "Close Diff View" },
  },
  config = function()
    require("diffview").setup({
      -- Use simple text icons to match your gitsigns config
      icons = {
        folder_closed = "+",
        folder_open = "-",
      },
      signs = {
        fold_closed = "+",
        fold_open = "-",
        done = "✓",
      },
      -- Enhanced diff highlighting to work well with Nordic theme
      enhanced_diff_hl = true,
      -- File panel configuration
      file_panel = {
        listing_style = "tree",
        tree_options = {
          flatten_dirs = true,
          folder_statuses = "only_folded",
        },
        win_config = {
          position = "left",
          width = 30, -- Slightly narrower to match minimal style
        },
      },
      -- Default view settings
      view = {
        default = {
          layout = "diff2_horizontal", -- Horizontal split by default
        },
        merge_tool = {
          layout = "diff3_horizontal",
        },
      },
      -- Minimal keymaps that don't conflict with your space leader
      keymaps = {
        view = {
          { "n", "<tab>", "<cmd>DiffviewToggleFiles<cr>", { desc = "Toggle file panel" } },
          { "n", "q", "<cmd>DiffviewClose<cr>", { desc = "Close diffview" } },
        },
        file_panel = {
          { "n", "<cr>", "<cmd>DiffviewOpen<cr>", { desc = "Open diff" } },
          { "n", "o", "<cmd>DiffviewOpen<cr>", { desc = "Open diff" } },
          { "n", "<tab>", "<cmd>DiffviewToggleFiles<cr>", { desc = "Toggle file panel" } },
          { "n", "q", "<cmd>DiffviewClose<cr>", { desc = "Close diffview" } },
        },
        option_panel = {
          { "n", "q", "<cmd>DiffviewClose<cr>", { desc = "Close diffview" } },
        },
        help_panel = {
          { "n", "q", "<cmd>DiffviewClose<cr>", { desc = "Close diffview" } },
        },
      },
    })
  end,
}
