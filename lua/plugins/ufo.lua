return {
    {
        "kevinhwang91/nvim-ufo",
        dependencies = {
            "kevinhwang91/promise-async",
        },
        event = "BufReadPost",
        opts = {
            provider_selector = function(bufnr, filetype, buftype)
                return { "treesitter", "indent" }
            end,
        },
        config = function(_, opts)
            require("ufo").setup(opts)

            -- Настройка fold колонки для красивых иконок
            vim.o.foldcolumn = "1"
            vim.o.foldlevel = 99
            vim.o.foldlevelstart = 99
            vim.o.foldenable = true

            -- Улучшенные маппинги для работы с folds
            vim.keymap.set("n", "zR", require("ufo").openAllFolds, { desc = "UFO: Open all folds" })
            vim.keymap.set("n", "zM", require("ufo").closeAllFolds, { desc = "UFO: Close all folds" })
            vim.keymap.set("n", "zr", require("ufo").openFoldsExceptKinds, { desc = "UFO: Open folds except kinds" })
            vim.keymap.set("n", "zm", require("ufo").closeFoldsWith, { desc = "UFO: Close folds with" })

            -- Preview fold без открытия
            vim.keymap.set("n", "K", function()
                local winid = require("ufo").peekFoldedLinesUnderCursor()
                if not winid then
                    -- Если нет fold под курсором, показываем LSP hover
                    vim.lsp.buf.hover()
                end
            end, { desc = "UFO: Peek fold or LSP hover" })
        end,
    },
}
