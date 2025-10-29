return {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
        -- Основные настройки
        cmdline = {
            view = "cmdline_popup",
            format = {
                -- Кастомизация отображения поиска
                search_down = { icon = " ▼" },
                search_up = { icon = " ▲" },
            },
        },
        messages = {
            enabled = true,
            view = "mini",       -- компактные сообщения
            view_error = "mini", -- сообщения об ошибках
            view_warn = "mini",  -- предупреждения
        },
        popupmenu = {
            enabled = true,
            backend = "nui", -- использует nui для красивого отображения
        },
        notify = {
            enabled = true,
            view = "notify",
            -- Фильтрация ненужных уведомлений
            filter = function(message, level, opts)
                if level == "warn" and string.find(message, "No information available") then
                    return false
                end
                return true
            end,
        },
        lsp = {
            -- Улучшенное отображение документации
            override = {
                ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                ["vim.lsp.util.stylize_markdown"] = true,
                ["cmp.entry.get_documentation"] = true,
            },
            hover = {
                enabled = true,
                view = "hover", -- специальный view для hover
                opts = {},
            },
            progress = {
                enabled = true,
                format = "lsp_progress",
                format_done = "lsp_progress_done",
                throttle = 1000 / 30, -- 30 fps
                view = "mini",
            },
            signature = {
                enabled = true,
                auto_open = {
                    enabled = true,
                    trigger = true, -- автоматически показывать сигнатуры
                },
            },
        },
        presets = {
            -- Пресеты для разных сценариев
            bottom_search = false,        -- не использовать старый стиль поиска
            command_palette = true,       -- удобная палитра команд
            long_message_to_split = true, -- длинные сообщения в split
            inc_rename = false,           -- отключить встроенный inc-rename
            lsp_doc_border = true,        -- границы для документации
        },
        routes = {
            -- Какие сообщения куда направлять
            {
                filter = { event = "msg_show", kind = "" },
                view = "mini",
            },
        },
        views = {
            -- Кастомизация внешнего вида
            cmdline_popup = {
                position = {
                    row = 5,
                    col = "50%",
                },
                size = {
                    width = 60,
                    height = "auto",
                },
                border = {
                    style = "rounded",
                    padding = { 0, 1 },
                },
            },
        },
    },
    dependencies = {
        "MunifTanjim/nui.nvim",
        "rcarriga/nvim-notify",
    }
}
