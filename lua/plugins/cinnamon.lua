return {
    {
        "declancm/cinnamon.nvim",
        version = "*",
        event = "VeryLazy",
        opts = {
            -- Опции анимации
            options = {
                delay = 7, -- Задержка между шагами анимации (ms)
                max_delta = {
                    line = nil, -- nil = без лимита для вертикального скролла
                    column = nil, -- nil = без лимита для горизонтального скролла
                },
            },

            -- Кеймапы
            keymaps = {
                basic = true, -- Half-page и full-page scrolling
                extra = true, -- <C-u>, <C-d>, <C-b>, <C-f>, gg, G
                extended = true, -- gd, gr, gi, /, n, N, *, #, ', `
            },

            -- Отключить для определенных filetypes
            disabled_filetypes = {
                "alpha", -- стартовый экран
                "NvimTree",
                "neo-tree",
                "dashboard",
                "lazy",
                "mason",
            },

            -- Максимальная ширина окна для анимации
            max_width = 120,
        },
        config = function(_, opts)
            require("cinnamon").setup(opts)

            -- Дополнительные кастомные маппинги
            local cinnamon = require("cinnamon")

            -- Центрированный поиск
            vim.keymap.set("n", "n", function()
                cinnamon.scroll("nzzzv")
            end, { desc = "Cinnamon: Next search result (centered)" })

            vim.keymap.set("n", "N", function()
                cinnamon.scroll("Nzzzv")
            end, { desc = "Cinnamon: Previous search result (centered)" })

            -- LSP с центрированием (если хотите переопределить)
            -- vim.keymap.set("n", "gd", function()
            --     cinnamon.scroll(function()
            --         vim.lsp.buf.definition()
            --         vim.cmd("normal! zz")
            --     end)
            -- end, { desc = "LSP: Go to definition (smooth)" })
        end,
    },
}
