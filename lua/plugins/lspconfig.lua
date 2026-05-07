return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "saghen/blink.cmp",
    },
    config = function()
      local user_settings = require("config.user-settings")

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
      local clangd_root = vim.fs.root(0, { "compile_commands.json", ".git" })
        or vim.fn.getcwd()

      vim.lsp.config("clangd", {
        cmd = {
          user_settings.clangd_bin,
          "--compile-commands-dir=" .. clangd_root .. "/" .. user_settings.clangd_compile_commands_dir,
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

      -- 配置 basedpyright，需要通过 pip 安装：pip install basedpyright
      -- 优先使用项目 .venv，不存在时回退到全局默认解释器
      local venv_python
      if vim.fn.has("win32") == 1 then
        venv_python = vim.fn.getcwd() .. "/.venv/Scripts/python.exe"
      else
        venv_python = vim.fn.getcwd() .. "/.venv/bin/python"
      end
      if vim.fn.filereadable(venv_python) == 0 then
        venv_python = user_settings.python_interpreter
      end

      vim.lsp.config("basedpyright", {
        capabilities = require("blink.cmp").get_lsp_capabilities(),
        settings = {
          basedpyright = {
            analysis = {
              typeCheckingMode = "basic",
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
              diagnosticMode = "openFilesOnly",
            },
          },
          python = {
            pythonPath = venv_python,
            defaultInterpreterPath = user_settings.python_interpreter,
          },
        },
      })

      vim.lsp.enable("basedpyright")
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
