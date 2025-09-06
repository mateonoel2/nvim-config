return {
  "saghen/blink.cmp",
  build = "cargo build --release",
  dependencies = {
    "giuxtaposition/blink-cmp-copilot",
  },
  opts = {
    fuzzy = {
      implementation = "lua",
    },
    keymap = {
      preset = "default",
      ["<Tab>"] = { "select_next", "fallback" },
      ["<S-Tab>"] = { "select_prev", "fallback" },
      ["<CR>"] = { "accept", "fallback" },
      ["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
      ["<C-e>"] = { "hide", "fallback" },
    },
    sources = {
      default = { "lsp", "path", "buffer", "copilot" },
      providers = {
        copilot = {
          name = "copilot",
          module = "blink-cmp-copilot",
          score_offset = 100,
          async = true,
        },
      },
    },
  },
}
