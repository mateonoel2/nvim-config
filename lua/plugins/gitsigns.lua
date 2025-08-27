return {
  'lewis6991/gitsigns.nvim',
  opts = {
    signs = {
      add          = { text = '+' },
      change       = { text = '~' },
      delete       = { text = '-' },
      topdelete    = { text = '‾' },
      changedelete = { text = '~' },
    },
    signcolumn = true,
    current_line_blame = true,
    current_line_blame_opts = {
      virt_text = true,
      virt_text_pos = 'eol',
      delay = 100,
    },
    on_attach = function(bufnr)
      local gitsigns = require('gitsigns')
      
      -- Toggle between HEAD and main as base
      local base_state = 'HEAD' -- Track state manually
      local function toggle_gitsigns_base()
        if base_state == 'HEAD' then
          gitsigns.change_base('main')
          base_state = 'main'
          print('Gitsigns base: main')
        else
          gitsigns.change_base(nil) -- Reset to default (HEAD)
          base_state = 'HEAD'
          print('Gitsigns base: HEAD')
        end
      end

      -- Add keybinding
      vim.keymap.set('n', '<leader>gb', toggle_gitsigns_base, { 
        buffer = bufnr, 
        desc = 'Toggle gitsigns base between HEAD and main' 
      })
    end,
  }
}
