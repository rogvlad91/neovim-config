return {
    {
        "tris203/precognition.nvim",
        event = "VeryLazy",
        opts = {
            -- Показывать подсказки сразу при старте
            startVisible = false, -- false = нужно включить вручную, true = всегда показывать

            -- Показывать пустую виртуальную линию если нет hints
            showBlankVirtLine = false,

            -- Highlights для подсказок (можно кастомизировать цвета)
            highlightColor = { link = "Comment" }, -- серый цвет как у комментариев

            -- Горизонтальные подсказки (на текущей строке)
            hints = {
                -- Начало/конец строки
                ["^"] = { text = "^", prio = 10 },
                ["$"] = { text = "$", prio = 10 },
                ["0"] = { text = "0", prio = 9 },

                -- Word motions
                ["w"] = { text = "w", prio = 10 },
                ["W"] = { text = "W", prio = 9 },
                ["b"] = { text = "b", prio = 10 },
                ["B"] = { text = "B", prio = 9 },
                ["e"] = { text = "e", prio = 10 },
                ["E"] = { text = "E", prio = 9 },

                -- Matching bracket
                ["%"] = { text = "%", prio = 8 },

                -- Можно добавить кастомные hints
                -- ["ge"] = { text = "ge", prio = 9 },
                -- ["gE"] = { text = "gE", prio = 8 },
            },

            -- Вертикальные подсказки (в gutter)
            gutterHints = {
                -- Top/Bottom
                ["G"] = { text = "G", prio = 10 },
                ["gg"] = { text = "gg", prio = 10 },

                -- Paragraphs
                ["{"] = { text = "{", prio = 9 },
                ["}"] = { text = "}", prio = 9 },

                -- Можно добавить другие
                -- ["("] = { text = "(", prio = 8 },
                -- [")"] = { text = ")", prio = 8 },
            },

            -- Отключить для определенных filetypes
            disabled_fts = {
                "NvimTree",
                "lazy",
                "mason",
                "alpha",
                "dashboard",
                "neo-tree",
                "Trouble",
                "trouble",
                "notify",
                "toggleterm",
                "TelescopePrompt",
                "help",
                "DBUI",
                "dbui",
                "dbout",
            },
        },

        config = function(_, opts)
            require("precognition").setup(opts)

            -- Установить цвета для hints (можно настроить)
            vim.api.nvim_set_hl(0, "PrecognitionHighlight", {
                fg = "#7aa2f7", -- голубой (как в Tokyo Night)
                -- bg = "#1a1b26", -- фон (опционально)
                bold = true,
            })

            -- Создать autocmd для автоматического показа в определенных случаях
            -- Например, показывать в Go файлах
            vim.api.nvim_create_autocmd("FileType", {
                pattern = { "go", "lua", "python", "javascript", "typescript" },
                callback = function()
                    -- Можно автоматически включать для определенных типов файлов
                    -- require("precognition").show()
                end,
            })
        end,

        keys = {
            {
                "<leader>pt",
                function()
                    require("precognition").toggle()
                end,
                desc = "Precognition: Toggle hints",
            },
            {
                "<leader>pp",
                function()
                    require("precognition").peek()
                end,
                desc = "Precognition: Peek (show until next move)",
            },
            {
                "<leader>ps",
                function()
                    require("precognition").show()
                end,
                desc = "Precognition: Show hints",
            },
            {
                "<leader>ph",
                function()
                    require("precognition").hide()
                end,
                desc = "Precognition: Hide hints",
            },
        },
    },
}
