return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      -- LSP 附加到 buffer 时自动设置快捷键
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(args)
          local opts = { buffer = args.buf, silent = true }
          -- 跳转到声明
          vim.keymap.set("n", "gd", vim.lsp.buf.declaration, opts)
          -- 跳转到定义
          vim.keymap.set("n", "gD", vim.lsp.buf.definition, opts)
          -- 显示悬浮文档
          vim.keymap.set("n", "gh", vim.lsp.buf.hover, opts)
          -- 跳转到实现
          vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
          -- 跳转到引用
          vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
          -- 以浮窗显示诊断
          vim.keymap.set("n", "go", vim.diagnostic.open_float, opts)
          vim.keymap.set("n", "gp", vim.diagnostic.goto_prev, opts)
          vim.keymap.set("n", "gn", vim.diagnostic.goto_next, opts)
        end,
      })
    end,
  },
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      -- 所有通过 Mason 安装的 LSP server 都会经过 handlers 自动 setup
      handlers = {
        -- 默认 handler：应用于所有 server
        function(server_name)
          require("lspconfig")[server_name].setup({})
        end,
      },
    },
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "neovim/nvim-lspconfig",
    },
  },
}
