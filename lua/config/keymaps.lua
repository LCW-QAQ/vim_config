-- ========================================
-- 按键映射（核心映射全部保留）
-- 说明：
-- - mode: "n" = 普通模式
-- - noremap = true → 非递归映射（对应原 noremap）
-- - noremap = false → 递归映射（对应原 map）
-- - silent = true → 不显示映射执行的命令
-- ========================================
local map = vim.keymap.set  -- 简化映射函数

map("n", "<c-j>", "5j", { noremap = true, silent = true })
map("n", "<c-k>", "5k", { noremap = true, silent = true })
map("n", "<c-h>", "5h", { noremap = true, silent = true })
map("n", "<c-l>", "5l", { noremap = true, silent = true })
map("v", "<c-j>", "5j", { noremap = true, silent = true })
map("v", "<c-k>", "5k", { noremap = true, silent = true })
map("v", "<c-h>", "5h", { noremap = true, silent = true })
map("v", "<c-l>", "5l", { noremap = true, silent = true })

-- 保存 & 退出
map("n", "<c-s>", ":w<cr>", { noremap = true, silent = true })  -- 快捷键保存
map("n", "Q", ":q<cr>", { noremap = true, silent = true })      -- Q 快速退出

-- 搜索结果自动居中
map("n", "N", "Nzz", { noremap = true, silent = true })
map("n", "n", "nzz", { noremap = true, silent = true })

-- 快速撤销/重做（原 <c-u> 映射到 <c-r>）
map("n", "<c-u>", "<c-r>", { noremap = false, silent = true })

-- 分屏切换（leader + 方向）
map("n", "<leader>k", "<c-w>k", { noremap = false, silent = true })
map("n", "<leader>j", "<c-w>j", { noremap = false, silent = true })
map("n", "<leader>h", "<c-w>h", { noremap = false, silent = true })
map("n", "<leader>l", "<c-w>l", { noremap = false, silent = true })

-- 调整分屏大小（方向键）
map("n", "<up>", ":res -5<cr>", { noremap = false, silent = true })
map("n", "<down>", ":res +5<cr>", { noremap = false, silent = true })
map("n", "<left>", ":vertical resize -5<cr>", { noremap = false, silent = true })  -- 补全空格，避免语法错误
map("n", "<right>", ":vertical resize +5<cr>", { noremap = false, silent = true })

-- 标签页操作
map("n", "te", ":tabe<cr>", { noremap = false, silent = true })   -- 新建标签页
map("n", "tn", ":tabn<cr>", { noremap = false, silent = true })   -- 下一个标签页
map("n", "tp", ":tabp<cr>", { noremap = false, silent = true })   -- 上一个标签页
map("n", "tc", ":tabc<cr>", { noremap = false, silent = true })   -- 关闭当前标签页

-- 快速分屏
map("n", "sv", "<c-w>v", { noremap = false, silent = true })      -- 垂直分屏
map("n", "sh", "<c-w>s", { noremap = false, silent = true })      -- 水平分屏

-- visual模式快速执行norm指令
map("v", "<leader>nm", ":norm ", { noremap = false, silent = false })

-- 可视模式下支持重复缩进
map("v", ">", ">gv", { noremap = true, silent = true })
map("v", "<", "<gv", { noremap = true, silent = true })


-- #BEGIN Plugin Keymaps

-- nvim-tree 快捷键
map("n", "<a-m>", ":NvimTreeOpen<cr>", { noremap = false, silent = false })

-- bufferline 左右Tab切换
map("n", "<a-h>", ":BufferLineCyclePrev<cr>", { noremap = false, silent = false })
map("n", "<a-l>", ":BufferLineCycleNext<cr>", { noremap = false, silent = false })
-- 新建buffer
map("n", "<leader>bn", ":enew <cr>", { noremap = true, silent = true })
-- 关闭当前buffer
map("n", "<leader>bc", ":bdelete!<cr>", { noremap = true, silent = true })
-- 关闭标签buffer
map("n", "<leader>bp", ":BufferLinePickClose<cr>", { noremap = true, silent = true })
-- 关闭非当前Buffer
map("n", "<leader>bo", ":BufferLineCloseLeft<cr>:BufferLineCloseRight<cr>", { noremap = true, silent = true })
-- 关闭右侧buffer
map("n", "<leader>br", ":BufferLineCloseRight<cr>", { noremap = true, silent = true })
-- 关闭左侧buffe
map("n", "<leader>bl", ":BufferLineCloseLeft<cr>", { noremap = true, silent = true })

-- #END Plugin Keymaps

