return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    require('telescope').setup({
      defaults = {
        file_ignore_patterns = { "node_modules", ".git/" },
        mappings = {
          i = {
            ["<C-j>"] = require('telescope.actions').move_selection_next,
            ["<C-k>"] = require('telescope.actions').move_selection_previous,
          },
        },
      },
      pickers = {
        find_files = {
          hidden = true
        }
      }
    })
  end,
}