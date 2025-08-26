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
  }
}