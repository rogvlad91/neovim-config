return {
    {
        "mrjones2014/legendary.nvim",
        priority = 10000,
        lazy = false,
        dependencies = {
            "kkharji/sqlite.lua", -- для frecency (часто используемые команды)
        },
        keys = {
            {
                "<leader>p",
                "<cmd>Legendary<cr>",
                desc = "Legendary: Command Palette",
                mode = { "n", "v" },
            },
            {
                "<leader>P",
                "<cmd>Legendary keymaps<cr>",
                desc = "Legendary: Search Keymaps",
            },
            {
                "<C-p>",
                "<cmd>Legendary commands<cr>",
                desc = "Legendary: Search Commands",
                mode = { "n", "v" },
            },
        },
        opts = {
            -- Сортировка по frecency (часто используемые сверху)
            sort = {
                frecency = {
                    db_root = vim.fn.stdpath("data") .. "/legendary/", -- где хранить статистику
                    max_timestamps = 10, -- сколько timestamps хранить
                },
                -- Можно добавить кастомную сортировку
                -- user_items = true,
                -- most_recent_first = true,
            },

            -- UI через Telescope
            select_prompt = "Legendary", -- заголовок окна
            select_opts = {
                prompt_title = "Legendary",
            },

            -- Кастомные фильтры
            include_builtin = true, -- включить встроенные Vim команды
            include_legendary_cmds = true, -- включить команды legendary

            -- Автокоманды
            autocmds = {
                -- Можно добавить описания для autocmds
            },

            -- Функции
            funcs = {
                -- Можно добавить кастомные функции
            },

            -- Скрапинг lazy.nvim
            scratchpad = {
                view = "float",
                results_view = "float",
            },

            -- Форматирование в telescope
            formatter = nil, -- использовать дефолтный

            -- Расширения
            extensions = {
                lazy_nvim = true,
                which_key = {
                    -- автоматически импортировать mappings из which-key
                    auto_register = true,
                },
                nvim_tree = false, -- если хотите добавить nvim-tree команды
                op_nvim = false,
                diffview = false,
            },

            -- Иконки для разных типов
            icons = {
                keymap = "󰌌",
                command = "",
                fn = "󰊕",
                itemgroup = "",
            },

            -- Кастомные keymaps и команды (необязательно, уже читаются из which-key)
            keymaps = {
                -- Дополнительные команды которые не определены через vim.keymap.set
            },

            commands = {
                -- Часто используемые команды с описаниями
                {
                    ":Lazy",
                    description = "Open Lazy plugin manager",
                },
                {
                    ":Mason",
                    description = "Open Mason LSP installer",
                },
                {
                    ":checkhealth",
                    description = "Check Neovim health",
                },
                {
                    ":Telescope",
                    description = "Open Telescope picker",
                },
                {
                    ":DBUI",
                    description = "Open Database UI",
                },
                {
                    ":GoTest",
                    description = "Run Go tests",
                },
                {
                    ":DapContinue",
                    description = "Start/continue debugging",
                },
                {
                    ":Neotree",
                    description = "Toggle file explorer",
                },
            },
        },

        config = function(_, opts)
            require("legendary").setup(opts)

            -- Добавление кастомных item groups (категории)
            require("legendary").itemgroup({
                -- Группа для Git команд
                itemgroup = "Git Operations",
                icon = "",
                description = "Git related commands",
                items = {
                    {
                        ":Git",
                        description = "Open LazyGit or fugitive",
                    },
                    {
                        ":Gitsigns toggle_current_line_blame",
                        description = "Toggle git blame line",
                    },
                },
            })

            -- Группа для Testing
            require("legendary").itemgroup({
                itemgroup = "Testing",
                icon = "󰙨",
                description = "Test related commands",
                items = {
                    {
                        ":Neotest summary",
                        description = "Open test summary",
                    },
                    {
                        ":Neotest output-panel",
                        description = "Toggle test output panel",
                    },
                },
            })

            -- Группа для Database
            require("legendary").itemgroup({
                itemgroup = "Database",
                icon = "",
                description = "Database operations",
                items = {
                    {
                        ":DBUIToggle",
                        description = "Toggle database UI",
                    },
                    {
                        ":DBUIFindBuffer",
                        description = "Find database buffer",
                    },
                    {
                        ":DBUIAddConnection",
                        description = "Add database connection",
                    },
                },
            })

            -- Автокоманды для Go файлов
            vim.api.nvim_create_autocmd("FileType", {
                pattern = "go",
                callback = function()
                    -- Добавить Go-специфичные команды в legendary
                    require("legendary").commands({
                        {
                            ":GoTestFunc",
                            description = "Test function under cursor",
                        },
                        {
                            ":GoTestFile",
                            description = "Test current file",
                        },
                        {
                            ":GoCoverage",
                            description = "Show test coverage",
                        },
                        {
                            ":GoFillStruct",
                            description = "Fill struct with default values",
                        },
                    })
                end,
            })
        end,
    },
}
