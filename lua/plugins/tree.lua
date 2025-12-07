return {
  {
    "nvim-tree/nvim-tree.lua",
    config = function ()
      require("nvim-tree").setup({
        update_cwd = true,
        reload_on_bufenter = true,
        -- 不显示 git 状态图标
        git = {
            enable = false
        },
        actions = {
          open_file = {
            -- 可选：打开文件时调整窗口大小（适配宽屏）
            resize_window = true,
          },
        },
        on_attach = function (bufnr)
          local api = require("nvim-tree.api")

          local function opts(desc)
            return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
          end

          -- 应用默认nvim-tree快捷键
          api.config.mappings.default_on_attach(bufnr)

          -- 移除<c-k>
          vim.keymap.del("n", "<c-k>", opts("remove <c-k>"))
          -- 查看文件信息改为<c-p>
          vim.keymap.set("n", "<c-p>", api.node.show_info_popup, opts("Info"))
          -- 支持跳转指定目录
          -- vim.keymap.set("n", "<leader>cr", api.tree.change_root, opts("change tree root"))
          vim.keymap.set("n", "<leader>cr", function()
          -- 优先获取当前打开文件的目录（若有）
          local current_file_dir = vim.fn.expand("%:p:h")
          local default_path = vim.fn.isdirectory(current_file_dir) == 1 and current_file_dir or vim.fn.getcwd()

          local input_path = vim.fn.input({
            prompt = "🔍 输入目标目录（回车=当前文件目录）：",
            default = default_path,
            completion = "dir",
          })

          if input_path == "" then
            -- 无输入时，直接切换到当前文件目录
            api.tree.change_root(default_path)
            api.tree.focus()
            vim.notify("✅ 切换到当前文件目录：" .. default_path, vim.log.levels.SUCCESS)
            return
          end

          -- 后续路径校验、切换逻辑和之前一致
          local abs_path = vim.fn.fnamemodify(input_path, ":p")
          if vim.fn.isdirectory(abs_path) ~= 1 then
            vim.notify("❌ 无效目录：" .. abs_path, vim.log.levels.ERROR)
            return
          end
          api.tree.change_root(abs_path)
          api.tree.focus()
          vim.notify("✅ 切换根目录到：" .. abs_path, vim.log.levels.SUCCESS)
          end, opts("change tree root"))
        end
      })
    end,
  }
}

