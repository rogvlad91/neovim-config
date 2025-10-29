-- Маппинг <leader> клавиши. Сейчас пробел.
vim.g.mapleader = " "

-- Вставка без затирания регистра
vim.keymap.set("x", "<leader>p", "\"_dP", { desc = "Paste without overwriting register" })

-- Копирование в системный буфер
vim.keymap.set("n", "<leader>y", "\"+yy", { desc = "Yank line to system clipboard" })
vim.keymap.set("v", "<leader>y", "\"+y", { desc = "Yank selection to system clipboard" })
vim.keymap.set("n", "<leader>Y", "\"+Y", { desc = "Yank to end of line to clipboard" })

-- Quickfix маппинг для быстрой навигации по варнингам
vim.keymap.set("n", "<leader>j", "<cmd>cnext<CR>zz", { desc = "Next quickfix item" })
vim.keymap.set("n", "<leader>k", "<cmd>cprev<CR>zz", { desc = "Previous quickfix item" })

-- Diagnostic маппинг
vim.keymap.set("n", "<leader>dn", "]d", { desc = "Next diagnostic" })
vim.keymap.set("n", "<leader>dp", "[d", { desc = "Previous diagnostic" })

-- БЫСТРАЯ ЗАМЕНАААААААА
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Search and replace word under cursor" })
