--[[ return { ]]
  {
    "neovim/nvim-lspconfig",
    on_attach = function ()
      -- 跳转到声明
      vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.declaration()<CR>", {silent = true, noremap = true})
      -- 跳转到定义
      vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.definition()<CR>", {silent = true, noremap = true})
      -- 显示注释文档
      vim.api.nvim_buf_set_keymap(bufnr, "n", "gh", "<cmd>lua vim.lsp.buf.hover()<CR>", {silent = true, noremap = true})
      -- 跳转到实现
      vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", {silent = true, noremap = true})
      -- 跳转到引用位置
      vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", {silent = true, noremap = true})
      -- 以浮窗形式显示错误
      vim.api.nvim_buf_set_keymap(bufnr, "n", "go", "<cmd>lua vim.diagnostic.open_float()<CR>", {silent = true, noremap = true})
      vim.api.nvim_buf_set_keymap(bufnr, "n", "gp", "<cmd>lua vim.diagnostic.goto_prev()<CR>", {silent = true, noremap = true})
      vim.api.nvim_buf_set_keymap(bufnr, "n", "gn", "<cmd>lua vim.diagnostic.goto_next()<CR>", {silent = true, noremap = true})
    end
  },
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {},
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "neovim/nvim-lspconfig",
    },
    config = function ()
      require("mason-lspconfig").setup {
        automatic_enable = true,
        -- ensure_installed = { "lua_ls", "rust_analyzer" },
      }
    end
  },
  {
    "onsails/lspkind-nvim"
  },
  {
    "hrsh7th/nvim-cmp",
    config = function ()
      local cmp = require("cmp")
      local lspkind = require("lspkind")
      cmp.setup({
        -- 设置代码片段引擎，用于根据代码片段补全
        snippet = {
          expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
          end,
        },

        window = {
        },

        mapping = {
          -- 选择上一个
          ['<C-p>'] = cmp.mapping.select_prev_item(),
          -- 选择下一个
          ['<C-n>'] = cmp.mapping.select_next_item(),
          -- 出现补全
          ['<A-.>'] = cmp.mapping(cmp.mapping.complete(), {'i', 'c'}),
          -- 取消补全
          ['<A-,>'] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
          }),

          -- 确认使用某个补全项
          ['<CR>'] = cmp.mapping.confirm({
            select = true,
            behavior = cmp.ConfirmBehavior.Replace
          }),

          -- 向上翻页
          ['<C-u>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), {'i', 'c'}),
          -- 向下翻页
          ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(4), {'i', 'c'}),
        },

        -- 补全来源
        sources = cmp.config.sources({
          {name = 'nvim_lsp'},
          {name = 'vsnip'},
          {name = 'buffer'},
          {name = 'path'}
        }),

        --根据文件类型来选择补全来源
        cmp.setup.filetype('gitcommit', {
          sources = cmp.config.sources({
            {name = 'buffer'}
          })
        }),

        -- 命令模式下输入 `/` 启用补全
        cmp.setup.cmdline('/', {
          mapping = cmp.mapping.preset.cmdline(),
          sources = {
            { name = 'buffer' }
          }
        }),

        -- 命令模式下输入 `:` 启用补全
        cmp.setup.cmdline(':', {
          mapping = cmp.mapping.preset.cmdline(),
          sources = cmp.config.sources({
            { name = 'path' }
          }, {
            { name = 'cmdline' }
          })
        }),

        -- 设置补全显示的格式
        formatting = {
          format = lspkind.cmp_format({
            with_text = true,
            maxwidth = 50,
            before = function(entry, vim_item)
              vim_item.menu = "[" .. string.upper(entry.source.name) .. "]"
              return vim_item
            end
          }),
        },
      })
    end
  }
}
