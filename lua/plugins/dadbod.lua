return {
    -- Основной плагин для работы с БД
    {
        "tpope/vim-dadbod",
        cmd = "DB",
    },

    -- UI для vim-dadbod
    {
        "kristijanhusak/vim-dadbod-ui",
        dependencies = {
            "tpope/vim-dadbod",
            "kristijanhusak/vim-dadbod-completion",
        },
        cmd = {
            "DBUI",
            "DBUIToggle",
            "DBUIAddConnection",
            "DBUIFindBuffer",
        },
        keys = {
            { "<leader>db", "<cmd>DBUIToggle<cr>", desc = "Database: Toggle UI" },
            { "<leader>dba", "<cmd>DBUIAddConnection<cr>", desc = "Database: Add connection" },
            { "<leader>dbf", "<cmd>DBUIFindBuffer<cr>", desc = "Database: Find buffer" },
        },
        init = function()
            -- Настройки vim-dadbod-ui
            vim.g.db_ui_use_nerd_fonts = 1
            vim.g.db_ui_show_database_icon = 1
            vim.g.db_ui_force_echo_notifications = 1
            vim.g.db_ui_win_position = "left"
            vim.g.db_ui_winwidth = 40

            -- Сохранение запросов
            vim.g.db_ui_save_location = vim.fn.stdpath("data") .. "/db_ui"

            -- Автодополнение
            vim.g.db_ui_use_nvim_notify = 1

            -- Иконки для таблиц
            vim.g.db_ui_icons = {
                expanded = {
                    db = "▾ ",
                    buffers = "▾ ",
                    saved_queries = "▾ ",
                    schemas = "▾ ",
                    schema = "▾ פּ",
                    tables = "▾ 藺",
                    table = "▾ ",
                },
                collapsed = {
                    db = "▸ ",
                    buffers = "▸ ",
                    saved_queries = "▸ ",
                    schemas = "▸ ",
                    schema = "▸ פּ",
                    tables = "▸ 藺",
                    table = "▸ ",
                },
                saved_query = "",
                new_query = "璘",
                tables = "離",
                buffers = "﬘",
                add_connection = "",
                connection_ok = "✓",
                connection_error = "✕",
            }

            -- Пример подключений (раскомментируйте и настройте свои)
            -- vim.g.dbs = {
            --     dev = "postgres://user:password@localhost:5432/mydb",
            --     staging = "postgres://user:password@staging:5432/mydb",
            --     production = "postgres://user:password@prod:5432/mydb",
            -- }

            -- Автокоманды для SQL файлов
            vim.api.nvim_create_autocmd("FileType", {
                pattern = { "sql", "mysql", "plsql" },
                callback = function()
                    -- Включаем автодополнение для SQL
                    require("cmp").setup.buffer({
                        sources = {
                            { name = "vim-dadbod-completion" },
                            { name = "buffer" },
                        },
                    })
                end,
            })
        end,
    },

    -- Автодополнение для dadbod
    {
        "kristijanhusak/vim-dadbod-completion",
        dependencies = "tpope/vim-dadbod",
        ft = { "sql", "mysql", "plsql" },
    },
}
