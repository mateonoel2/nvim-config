return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  config = function()
    local wk = require("which-key")
    local on = true

    local function apply(enabled)
      if enabled then
        wk.setup({ delay = 0 })        -- normal behavior
      else
        wk.setup({
          delay = 1e9,                   -- effectively never shows
          show_keys = false,             -- no cmdline hints
          show_help = false,
        })
      end
      on = enabled
      vim.notify("which-key: "..(on and "ON" or "OFF"))
    end

    apply(true)
    vim.keymap.set("n", "<leader>w", function() apply(not on) end, { desc = "Toggle which-key" })
  end,
}
