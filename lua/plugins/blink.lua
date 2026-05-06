return {
  {
    "saghen/blink.cmp",
    dependencies = {
      "saghen/blink.lib",
      "rafamadriz/friendly-snippets",
    },
    build = function()
      require("blink.cmp").build():wait(60000)
    end,

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      -- Tab 接受补全，类似 VSCode 体验
      keymap = { preset = "super-tab" },

      -- 选中补全项时自动显示文档
      completion = {
        documentation = { auto_show = true },
      },

      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
      },

      fuzzy = {
        implementation = "rust",
      },
    },
  },
}
