return {
    {
        "m4xshen/hardtime.nvim",
        dependencies = { "MunifTanjim/nui.nvim" },
        event = "VeryLazy",
        opts = {
            -- Режим ограничений: "block" (блокировать) или "hint" (только предупреждать)
            -- Рекомендация: начните с "hint", через неделю переключите на "block"
            restriction_mode = "hint", -- начинаем мягко

            -- Максимум повторений клавиши перед блокировкой/предупреждением
            max_count = 4,

            -- Максимальное время (ms) между нажатиями для подсчета как "повторение"
            max_time = 1000,

            -- Отключить mouse в normal и visual режимах
            disable_mouse = true,

            -- Показывать подсказки о лучших альтернативах
            hint = true,

            -- Показывать уведомления через nvim-notify (у вас установлен)
            notification = true,

            -- Список разрешенных клавиш (не блокируются даже при повторении)
            allow_different_key = false,

            -- Включить в этих режимах
            enabled = true,

            -- Отключить в определенных filetypes
            disabled_filetypes = {
                "qf", -- quickfix
                "netrw",
                "NvimTree",
                "lazy",
                "mason",
                "oil",
                "DBUI",
                "dbui",
                "dbout",
                "help",
                "alpha", -- стартовый экран
                "dashboard",
                "neo-tree",
                "Trouble",
                "trouble",
                "notify",
                "toggleterm",
                "TelescopePrompt",
                "starter",
            },

            -- Отключить в этих buftypes
            disabled_buftypes = {
                "terminal",
                "nofile",
                "prompt",
            },

            -- Ограничения на конкретные клавиши
            restricted_keys = {
                -- Базовые движения
                ["h"] = { "n", "x" }, -- normal и visual
                ["j"] = { "n", "x" },
                ["k"] = { "n", "x" },
                ["l"] = { "n", "x" },

                -- Arrow keys
                ["<Up>"] = { "n", "x" },
                ["<Down>"] = { "n", "x" },
                ["<Left>"] = { "n", "x" },
                ["<Right>"] = { "n", "x" },

                -- Word motions (ограничиваем если спамят)
                ["w"] = { "n", "x" },
                ["b"] = { "n", "x" },
                ["e"] = { "n", "x" },

                -- Прокрутка (можно убрать если мешает)
                -- ["<C-d>"] = {},
                -- ["<C-u>"] = {},
            },

            -- Hints - что предлагать вместо плохих привычек
            hints = {
                -- Вертикальные движения
                ["k%^+"] = {
                    message = function(keys)
                        return "Use - instead of " .. keys
                    end,
                    length = 2,
                },
                ["j%^+"] = {
                    message = function(keys)
                        return "Use + or } instead of " .. keys
                    end,
                    length = 2,
                },

                -- Горизонтальные движения
                ["h%^+"] = {
                    message = function(keys)
                        return "Use b or ^ instead of " .. keys
                    end,
                    length = 3,
                },
                ["l%^+"] = {
                    message = function(keys)
                        return "Use w or $ instead of " .. keys
                    end,
                    length = 3,
                },

                -- Word motions
                ["w%^+"] = {
                    message = function(keys)
                        return "Use f/t or search (/) instead of " .. keys
                    end,
                    length = 4,
                },

                -- Delete patterns
                ["d[hjkl]%^+"] = {
                    message = function()
                        return "Use d{motion} (dw, d}, di\", etc.)"
                    end,
                    length = 3,
                },

                -- Неэффективные паттерны
                ["di[\"'`]i"] = {
                    message = function()
                        return "Use ci\" instead of di\"i"
                    end,
                },
            },
        },

        config = function(_, opts)
            require("hardtime").setup(opts)

            -- Показать welcome сообщение
            vim.defer_fn(function()
                vim.notify(
                    "🎯 Hardtime enabled! Break bad habits, master Vim motions.\n\n"
                        .. "Mode: "
                        .. opts.restriction_mode
                        .. "\n"
                        .. "Commands:\n"
                        .. ":Hardtime toggle\n"
                        .. ":Hardtime report",
                    vim.log.levels.INFO,
                    { title = "Hardtime.nvim" }
                )
            end, 1000)
        end,

        keys = {
            { "<leader>ht", "<cmd>Hardtime toggle<cr>", desc = "Hardtime: Toggle" },
            { "<leader>hr", "<cmd>Hardtime report<cr>", desc = "Hardtime: Show report" },
            { "<leader>he", "<cmd>Hardtime enable<cr>", desc = "Hardtime: Enable" },
            { "<leader>hd", "<cmd>Hardtime disable<cr>", desc = "Hardtime: Disable" },
        },
    },
}
