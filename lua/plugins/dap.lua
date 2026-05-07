return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio", -- dap-ui 依赖的异步库
      "mfussenegger/nvim-dap-python", -- Python 调试适配器
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      local user_settings = require("config.user-settings")

      -- 初始化 dap-ui
      dapui.setup()

      -- 自动在调试开始/结束时打开/关闭 UI
      dap.listeners.before.attach.dapui_config = dapui.open
      dap.listeners.before.launch.dapui_config = dapui.open
      dap.listeners.before.event_terminated.dapui_config = dapui.close
      dap.listeners.before.event_exited.dapui_config = dapui.close

      -- 配置 Python 调试适配器（debugpy），优先使用项目 .venv
      local venv_python
      if vim.fn.has("win32") == 1 then
        venv_python = vim.fn.getcwd() .. "/.venv/Scripts/python.exe"
      else
        venv_python = vim.fn.getcwd() .. "/.venv/bin/python"
      end
      if vim.fn.filereadable(venv_python) == 0 then
        venv_python = user_settings.python_interpreter
      end

      -- dap-python.setup 内部自动配置 debugpy adapter
      require("dap-python").setup(venv_python)
    end,
  },
}
