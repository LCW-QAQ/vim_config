return {
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    event = "VeryLazy",
    opts = {
      move = {
        enable = true,
        -- 跳转后记录到 vim 跳转列表（可通过 Ctrl+O/I 回退/前进）
        set_jumps = true, 
        -- 自定义跳转按键映射（buffer 局部）
        keys = {
          -- 下一个文本对象的「开始位置」
          goto_next_start = {
            ["]f"] = "@function.outer",
            ["]c"] = "@class.outer",
            ["]a"] = "@parameter.inner",
          },
          -- 下一个文本对象的「结束位置」
          goto_next_end = {
            ["]F"] = "@function.outer",
            ["]C"] = "@class.outer",
            ["]A"] = "@parameter.inner",
          },
          -- 上一个文本对象的「开始位置」
          goto_previous_start = {
            ["[f"] = "@function.outer",
            ["[c"] = "@class.outer",
            ["[a"] = "@parameter.inner",
          },
          -- 上一个文本对象的「结束位置」
          goto_previous_end = {
            ["[F"] = "@function.outer",
            ["[C"] = "@class.outer",
            ["[A"] = "@parameter.inner",
          },
        },
      },
      select = {
        -- 1. 自动向前跳转至文本对象（类似 targets.vim 行为）
        -- 开启后，光标无需精准定位在文本对象开头，插件会自动向前「预判」并跳转至目标文本对象的范围（比如光标在函数中间，
        -- 按 af 仍能选中整个函数），提升操作流畅度。
        lookahead = true,
        -- 2. 不同文本对象对应的可视化选择模式
        -- 定义不同文本对象对应的 Vim 可视化模式（适配不同代码结构的选择需求）：
        --   v：字符级可视化（默认），选单个 / 多个字符（适合参数这类「行内短结构」）；
        --   V：行级可视化，选整行（适合函数这类「多行结构」）；
        --   <c-v>：块级可视化（Ctrl+V），选矩形块（适合类 / 结构体这类「嵌套块结构」）。
        --   其中 @parameter.outer/@function.outer/@class.outer 是 Treesitter 的「捕获组」，对应 textobjects.scm 中定义的「参数外部」「函数外部」「类外部」文本对象。
        selection_modes = {
          ['@parameter.outer'] = 'v', -- 字符级可视化（charwise）
          ['@function.outer'] = 'V',  -- 行级可视化（linewise）
          ['@class.outer'] = '<c-v>', -- 块级可视化（blockwise）
        },
        -- 3. 是否包含文本对象前后的空白字符
        -- 是否包含文本对象前后的空白字符（比如换行、空格）。
        -- 关闭时仅选文本对象本身；开启后类似 Vim 内置的 ap（选段落包含空白），
        -- 这里默认关闭以保证选择精准。也可以通过函数自定义不同文本对象是否包含空白。
        include_surrounding_whitespace = false,
      },
    },
    config = function(_, opts)
      local TS = require("nvim-treesitter-textobjects")
      TS.setup(opts)

      -- 定义「buffer 绑定映射」的核心函数
      local function attach(buf)
        local ft = vim.bo[buf].filetype
        -- 跳过：move 未启用 / 当前文件类型不支持 treesitter textobjects
        if not (opts.move.enable) then
          return
        end

        -- 遍历 move.keys 中的所有跳转规则
        local moves = opts.move.keys or {}
        for method, keymaps in pairs(moves) do
            for key, query in pairs(keymaps) do
              -- 支持单个 query 或多个 query 数组（兼容扩展场景）
              local queries = type(query) == "table" and query or { query }
              -- 生成按键描述（比如「Next Function Start」「Prev Class End」）
              local parts = {}
              for _, q in ipairs(queries) do
                local part = q:gsub("@", ""):gsub("%..*", "") -- 提取文本对象名称（如 function/class）
                part = part:sub(1, 1):upper() .. part:sub(2) -- 首字母大写
                table.insert(parts, part)
              end
              local desc_prefix = key:sub(1, 1) == "[" and "Prev " or "Next "
              local desc_suffix = key:sub(2, 2) == key:sub(2, 2):upper() and " End" or " Start"
              local desc = desc_prefix .. table.concat(parts, " or ") .. desc_suffix

              -- 跳过 diff 模式下的类跳转（避免冲突）
              if not (vim.wo.diff and key:find("[cC]")) then
                -- 绑定按键：n/x/o 模式（普通/可视/操作符等待），buffer 局部映射
                vim.keymap.set({ "n", "x", "o" }, key, function()
                  require("nvim-treesitter-textobjects.move")[method](query, "textobjects")
                end, {
                buffer = buf,
                desc = desc, -- 按键描述（WhichKey 会显示）
                silent = true, -- 静默执行（不弹提示）
              })
            end
          end
        end
      end

      -- 自动命令：新打开文件时绑定映射
      local augroup = vim.api.nvim_create_augroup("lazy_treesitter_textobjects", { clear = true })
      vim.api.nvim_create_autocmd("FileType", {
        group = augroup,
        callback = function(ev)
          attach(ev.buf)
        end,
      })

      -- 对已打开的所有 buffer 批量绑定映射
      vim.tbl_map(attach, vim.api.nvim_list_bufs())
    end,
  }
}
