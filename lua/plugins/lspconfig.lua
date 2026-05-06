return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "saghen/blink.cmp",
    },
    config = function()
      -- LSP 附加到 buffer 时自动设置快捷键
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(args)
          local opts = { buffer = args.buf, silent = true }
          vim.keymap.set("n", "gd", vim.lsp.buf.declaration, opts)
          vim.keymap.set("n", "gD", vim.lsp.buf.definition, opts)
          vim.keymap.set("n", "gh", vim.lsp.buf.hover, opts)
          vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
          vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
          vim.keymap.set("n", "go", vim.diagnostic.open_float, opts)
          vim.keymap.set("n", "gp", vim.diagnostic.goto_prev, opts)
          vim.keymap.set("n", "gn", vim.diagnostic.goto_next, opts)
        end,
      })

      -- 配置 clangd，使用 MSYS2 安装的 clangd
      vim.lsp.config("clangd", {
        cmd = {
          "D:/software/msys64/ucrt64/bin/clangd.exe",
          "--compile-commands-dir=${workspaceFolder}/build",
          "--background-index",
          "--completion-style=detailed",
          "--header-insertion=never",
          "--log=info",
        },
        capabilities = vim.tbl_deep_extend(
          "force",
          {},
          require("blink.cmp").get_lsp_capabilities(),
          { offsetEncoding = { "utf-8", "utf-16" } }
        ),
      })

      vim.lsp.enable("clangd")
    end,
  },
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "neovim/nvim-lspconfig",
    },
  },
}
