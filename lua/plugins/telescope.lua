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
    
    -- Keymaps
    local builtin = require('telescope.builtin')
    vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Find files' })
    vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Live grep' })
    vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Find buffers' })
    vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Help tags' })
    vim.keymap.set('n', '<leader>gs', builtin.git_status, { desc = 'Git status' })
    vim.keymap.set('n', '<leader>gc', builtin.git_commits, { desc = 'Git commits' })
    
    -- Custom picker for files changed in branch
    vim.keymap.set('n', '<leader>gd', function()
      require('telescope.builtin').git_files({
        prompt_title = 'Files changed in branch',
        git_command = { 'git', 'diff', '--name-only', 'main..HEAD' },
        previewer = require('telescope.previewers').new_termopen_previewer({
          get_command = function(entry)
            return { 'git', 'diff', 'main..HEAD', '--', entry.value }
          end
        })
      })
    end, { desc = 'Git diff files (branch)' })
  end,
}
