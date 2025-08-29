return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("nvim-tree").setup({
      sort = {
        sorter = "case_sensitive",
      },
      view = {
        width = 30,
        side = "right",
      },
      renderer = {
        group_empty = true,
        icons = {
          git_placement = "before",
        },
      },
      git = {
        enable = true,
        ignore = false,
      },
      filters = {
        dotfiles = true,
      },
    })
    
    -- Key mapping to toggle nvim-tree with leader + E
    vim.keymap.set("n", "<leader>E", "<cmd>NvimTreeToggle<cr>", { desc = "Toggle file explorer" })
  end,
}
