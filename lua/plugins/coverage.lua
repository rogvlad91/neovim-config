return {
    {
        "andythigpen/nvim-coverage",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        cmd = {
            "Coverage",
            "CoverageLoad",
            "CoverageLoadLcov",
            "CoverageShow",
            "CoverageHide",
            "CoverageToggle",
            "CoverageClear",
            "CoverageSummary",
        },
        keys = {
            { "<leader>cc", "<cmd>Coverage<cr>", desc = "Coverage: Toggle coverage" },
            { "<leader>cl", "<cmd>CoverageLoad<cr>", desc = "Coverage: Load coverage file" },
            { "<leader>cs", "<cmd>CoverageSummary<cr>", desc = "Coverage: Show summary" },
            { "<leader>ch", "<cmd>CoverageHide<cr>", desc = "Coverage: Hide coverage" },
        },
        opts = {
            auto_reload = true, -- Автоматически перезагружать при изменении файла
            load_coverage_cb = function(ftype)
                -- Уведомление при загрузке
                vim.notify("Loaded " .. ftype .. " coverage", vim.log.levels.INFO)
            end,
            signs = {
                covered = { hl = "CoverageCovered", text = "▎" },
                uncovered = { hl = "CoverageUncovered", text = "▎" },
                partial = { hl = "CoveragePartial", text = "▎" },
            },
            summary = {
                min_coverage = 80.0, -- Минимальный процент coverage для "хорошего" покрытия
            },
            lang = {
                go = {
                    -- Для Go используем coverage.out из neotest
                    coverage_file = vim.fn.getcwd() .. "/coverage.out",
                },
            },
        },
        config = function(_, opts)
            require("coverage").setup(opts)

            -- Настройка цветов для coverage signs
            vim.api.nvim_set_hl(0, "CoverageCovered", { fg = "#A6E3A1", bold = true }) -- Зеленый
            vim.api.nvim_set_hl(0, "CoverageUncovered", { fg = "#F38BA8", bold = true }) -- Красный
            vim.api.nvim_set_hl(0, "CoveragePartial", { fg = "#F9E2AF", bold = true }) -- Желтый

            -- Автоматически загружать coverage после запуска тестов с neotest
            vim.api.nvim_create_autocmd("User", {
                pattern = "NeotestRunComplete",
                callback = function()
                    -- Проверяем что coverage файл существует
                    local coverage_file = vim.fn.getcwd() .. "/coverage.out"
                    if vim.fn.filereadable(coverage_file) == 1 then
                        vim.schedule(function()
                            require("coverage").load(true)
                        end)
                    end
                end,
            })
        end,
    },
}
