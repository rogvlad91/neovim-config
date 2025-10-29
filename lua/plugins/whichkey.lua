return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
        preset = "modern", -- classic, modern, helix
        delay = 500, -- задержка перед показом подсказки (ms)

        -- Настройки окна
        win = {
            border = "rounded", -- none, single, double, rounded, solid, shadow
            padding = { 1, 2 }, -- дополнительные отступы
            title = true,
            title_pos = "center",
            zindex = 1000,
        },

        -- Иконки для типов клавиш
        icons = {
            breadcrumb = "»", -- символ используемый в командном режиме
            separator = "➜", -- символ между клавишей и описанием
            group = "+", -- символ для групп
            ellipsis = "…",

            -- Иконки по умолчанию для разных типов
            mappings = true,
            keys = {
                Up = " ",
                Down = " ",
                Left = " ",
                Right = " ",
                C = "󰘴 ",
                M = "󰘵 ",
                S = "󰘶 ",
                CR = "󰌑 ",
                Esc = "󱊷 ",
                ScrollWheelDown = "󱕐 ",
                ScrollWheelUp = "󱕑 ",
                NL = "󰌑 ",
                BS = "⌫",
                Space = "󱁐 ",
                Tab = "󰌒 ",
            },
        },

        -- Скрыть маппинги для которых вы можете получить помощь другим способом
        show_help = true,
        show_keys = true,

        -- Отключить для определенных плагинов
        disable = {
            filetypes = {},
            buftypes = {},
        },
    },

    config = function(_, opts)
        local wk = require("which-key")
        wk.setup(opts)

        -- Регистрация групп с иконками
        wk.add({
            -- ========================================
            -- ОСНОВНЫЕ ГРУППЫ LEADER KEY
            -- ========================================

            { "<leader>f", group = "󰍉 Find (Telescope)", icon = "󰍉" },
            { "<leader>g", group = " Git", icon = "" },
            { "<leader>t", group = "󰙨 Test (Neotest)", icon = "󰙨" },
            { "<leader>d", group = " Debug/Database", icon = "" },
            { "<leader>b", group = "󰓩 Buffer", icon = "󰓩" },
            { "<leader>c", group = " Code/Coverage", icon = "" },
            { "<leader>h", group = " Git Hunk", icon = "" },
            { "<leader>v", group = " LSP", icon = "" },
            { "<leader>x", group = " Trouble/Diagnostics", icon = "" },
            { "<leader>n", group = "󰎚 Notify", icon = "󰎚" },
            { "<leader>s", group = " Search/Replace", icon = "" },
            { "<leader>p", group = " Legendary (Command Palette)", icon = "" },

            -- ========================================
            -- TELESCOPE SUBGROUPS
            -- ========================================

            { "<leader>fw", group = " Telescope Word", icon = "" },

            -- ========================================
            -- GIT OPERATIONS
            -- ========================================

            -- Git conflict
            { "<leader>go", desc = "Git Conflict: Choose ours" },
            { "<leader>gt", desc = "Git Conflict: Choose theirs" },
            { "<leader>gn", desc = "Git Conflict: Choose none" },
            { "<leader>gb", desc = "Git Conflict: Choose both" },

            -- ========================================
            -- DATABASE
            -- ========================================

            { "<leader>db", group = " Database", icon = "" },
            { "<leader>dba", desc = "Database: Add connection" },
            { "<leader>dbf", desc = "Database: Find buffer" },

            -- ========================================
            -- TESTING & COVERAGE
            -- ========================================

            -- Neotest (уже есть <leader>t группа выше)
            { "<leader>tt", desc = "Test: Run nearest" },
            { "<leader>tf", desc = "Test: Run file" },
            { "<leader>ta", desc = "Test: Run all" },
            { "<leader>td", desc = "Test: Debug nearest" },
            { "<leader>ts", desc = "Test: Stop" },
            { "<leader>tl", desc = "Test: Run last" },
            { "<leader>tw", desc = "Test: Toggle watch mode" },
            { "<leader>to", desc = "Test: Show output" },
            { "<leader>tO", desc = "Test: Toggle output panel" },
            { "<leader>tS", desc = "Test: Toggle summary" },

            -- Coverage (уже есть <leader>c группа выше)
            { "<leader>cc", desc = "Coverage: Toggle" },
            { "<leader>cl", desc = "Coverage: Load file" },
            { "<leader>cs", desc = "Coverage: Show summary" },
            { "<leader>ch", desc = "Coverage: Hide" },

            -- ========================================
            -- TRAINING PLUGINS
            -- ========================================

            -- Hardtime
            { "<leader>h", group = "🎓 Hardtime (Training)", icon = "🎓", mode = "n" },
            { "<leader>ht", desc = "Hardtime: Toggle" },
            { "<leader>hr", desc = "Hardtime: Show report" },
            { "<leader>he", desc = "Hardtime: Enable" },
            { "<leader>hd", desc = "Hardtime: Disable" },

            -- Precognition
            { "<leader>p", group = " Precognition/Palette", icon = "" },
            { "<leader>pt", desc = "Precognition: Toggle hints" },
            { "<leader>pp", desc = "Precognition: Peek" },
            { "<leader>ps", desc = "Precognition: Show hints" },
            { "<leader>ph", desc = "Precognition: Hide hints" },

            -- Legendary (Command Palette) - уже под <leader>p
            { "<leader>p", desc = "Legendary: Command Palette" }, -- основная команда
            { "<leader>P", desc = "Legendary: Search Keymaps" },

            -- ========================================
            -- BRACKETS NAVIGATION
            -- ========================================

            { "[", group = " Previous" },
            { "]", group = " Next" },

            -- Todo comments
            { "[t", desc = "Previous: Todo comment" },
            { "]t", desc = "Next: Todo comment" },

            -- Git conflicts
            { "[x", desc = "Previous: Git conflict" },
            { "]x", desc = "Next: Git conflict" },

            -- Git changes (hunks)
            { "[c", desc = "Previous: Git change" },
            { "]c", desc = "Next: Git change" },

            -- Diagnostics
            { "[d", desc = "Previous: Diagnostic" },
            { "]d", desc = "Next: Diagnostic" },

            -- Test failures (neotest)
            { "[t", desc = "Previous: Failed test" },
            { "]t", desc = "Next: Failed test" },

            -- ========================================
            -- VISUAL MODE
            -- ========================================

            { "<leader>h", group = " Git Hunk", mode = "v" },

            -- ========================================
            -- GO SPECIFIC
            -- ========================================

            { "<leader>i", group = " Go Commands", icon = "" },

            -- ========================================
            -- NOTIFY
            -- ========================================

            { "<leader>nd", desc = "Notify: Dismiss all" },
            { "<leader>nh", desc = "Notify: Show history" },

            -- ========================================
            -- UFO (FOLDING)
            -- ========================================

            { "z", group = " Folding (UFO)", icon = "" },
            { "zR", desc = "UFO: Open all folds" },
            { "zM", desc = "UFO: Close all folds" },
            { "zr", desc = "UFO: Open folds except kinds" },
            { "zm", desc = "UFO: Close folds with" },
            { "K", desc = "UFO: Peek fold or LSP hover" },

            -- ========================================
            -- CINNAMON (SMOOTH SCROLL)
            -- ========================================

            { "<C-d>", desc = "Scroll: Half page down (smooth)" },
            { "<C-u>", desc = "Scroll: Half page up (smooth)" },
            { "<C-f>", desc = "Scroll: Full page down (smooth)" },
            { "<C-b>", desc = "Scroll: Full page up (smooth)" },

            -- ========================================
            -- HBAC (BUFFER MANAGEMENT)
            -- ========================================

            { "<leader>bp", desc = "Buffer: Pin/Unpin (HBAC)" },
            { "<leader>ba", desc = "Buffer: Close all unpinned" },
        })
    end,

    keys = {
        {
            "<leader>?",
            function()
                require("which-key").show({ global = false })
            end,
            desc = "Buffer Local Keymaps (which-key)",
        },
        {
            "<leader><leader>",
            function()
                require("which-key").show({ global = true })
            end,
            desc = "All Keymaps (which-key)",
        },
    },
}
