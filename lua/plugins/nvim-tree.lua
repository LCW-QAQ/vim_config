return {
  {
    "nvim-tree/nvim-tree.lua",
    config = function ()
      require("nvim-tree").setup({
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
        end
      })
    end,
  }
}

