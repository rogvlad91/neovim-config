return {
    'akinsho/bufferline.nvim',
    version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
        require("bufferline").setup({
            options = {
                mode = "buffers", -- Режим: "buffers" (по умолчанию) или "tabs"
                numbers = "none", -- Нумерация: "none" | "ordinal" | "buffer_id"
                close_command = "bdelete! %d", -- Команда закрытия буфера
                right_mouse_command = "bdelete! %d", -- ПКМ → закрыть
                left_mouse_command = "buffer %d", -- ЛКМ → переключиться
                middle_mouse_command = nil, -- Средняя кнопка → ничего
                indicator = {
                    style = 'none', -- или 'icon' | 'underline'
                },
                buffer_close_icon = '×', -- Иконка закрытия
                modified_icon = '●', -- Иконка изменённого буфера
                close_icon = '', -- Альтернативная иконка закрытия
                left_trunc_marker = '', -- Маркер обрезанного текста слева
                right_trunc_marker = '', -- Маркер обрезанного текста справа
                max_name_length = 18, -- Макс. длина имени буфера
                max_prefix_length = 15, -- Макс. длина префикса
                truncate_names = true, -- Обрезать длинные имена
                tab_size = 18, -- Ширина вкладки
                diagnostics = "nvim_lsp", -- Источник диагностики (nvim_lsp, coc)
                diagnostics_update_in_insert = false, -- Обновлять диагностику в режиме insert?
                offsets = {
                    { filetype = "NvimTree", text = "File Explorer", text_align = "left" }
                },
                color_icons = true, -- Цветные иконки
                show_buffer_icons = true, -- Показывать иконки буферов
                show_buffer_close_icons = true, -- Показывать иконки закрытия
                show_close_icon = true, -- Показывать общую иконку закрытия
                show_tab_indicators = true, -- Показывать индикаторы вкладок
                separator_style = "thin", -- Стиль разделителя: "slant" | "thick" | "thin"
                enforce_regular_tabs = false, -- Фиксировать ширину вкладок?
                always_show_bufferline = true, -- Всегда показывать bufferline?
            }
        })

        -- Горячие клавиши
        vim.keymap.set('n', '<Tab>', '<Cmd>BufferLineCycleNext<CR>', { silent = true, desc = "Bufferline: Next buffer" })
        vim.keymap.set('n', '<S-Tab>', '<Cmd>BufferLineCyclePrev<CR>', { silent = true, desc = "Bufferline: Previous buffer" })
        vim.keymap.set('n', '<leader>x', function()
            local cur_buf = vim.api.nvim_get_current_buf()
            vim.cmd("bp")             -- Переключиться на предыдущий
            vim.cmd("bd " .. cur_buf) -- Закрыть исходный
        end, { silent = true, desc = "Bufferline: Close current buffer" })
        -- Закрытие других буферов (кроме текущего)
        vim.keymap.set('n', '<leader>X', '<Cmd>BufferLineCloseOthers<CR>', { desc = "Bufferline: Close other buffers" })
    end
}
