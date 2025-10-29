return {
    {
        "nvim-neotest/neotest",
        dependencies = {
            "nvim-neotest/nvim-nio",
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            "antoinemadec/FixCursorHold.nvim",
            -- Go adapter
            "fredrikaverpil/neotest-golang",
        },
        keys = {
            {
                "<leader>tt",
                function()
                    require("neotest").run.run()
                end,
                desc = "Neotest: Run nearest test",
            },
            {
                "<leader>tf",
                function()
                    require("neotest").run.run(vim.fn.expand("%"))
                end,
                desc = "Neotest: Run current file",
            },
            {
                "<leader>ta",
                function()
                    require("neotest").run.run({ suite = true })
                end,
                desc = "Neotest: Run all tests",
            },
            {
                "<leader>td",
                function()
                    require("neotest").run.run({ strategy = "dap" })
                end,
                desc = "Neotest: Debug nearest test",
            },
            {
                "<leader>ts",
                function()
                    require("neotest").run.stop()
                end,
                desc = "Neotest: Stop test",
            },
            {
                "<leader>to",
                function()
                    require("neotest").output.open({ enter = true, auto_close = true })
                end,
                desc = "Neotest: Show output",
            },
            {
                "<leader>tO",
                function()
                    require("neotest").output_panel.toggle()
                end,
                desc = "Neotest: Toggle output panel",
            },
            {
                "<leader>tS",
                function()
                    require("neotest").summary.toggle()
                end,
                desc = "Neotest: Toggle summary",
            },
            {
                "[t",
                function()
                    require("neotest").jump.prev({ status = "failed" })
                end,
                desc = "Neotest: Previous failed test",
            },
            {
                "]t",
                function()
                    require("neotest").jump.next({ status = "failed" })
                end,
                desc = "Neotest: Next failed test",
            },
        },
        opts = function()
            return {
                adapters = {
                    require("neotest-golang")({
                        -- Опции для Go адаптера
                        go_test_args = {
                            "-v",
                            "-race",
                            "-count=1",
                            "-timeout=60s",
                            "-coverprofile=coverage.out",
                        },
                        dap_go_enabled = true, -- Включить интеграцию с nvim-dap-go
                    }),
                },
                status = {
                    enabled = true,
                    signs = true,
                    virtual_text = true,
                },
                output = {
                    enabled = true,
                    open_on_run = "short", -- Открывать output только для коротких тестов
                },
                quickfix = {
                    enabled = true,
                    open = false,
                },
                summary = {
                    enabled = true,
                    animated = true,
                    follow = true,
                    expand_errors = true,
                },
                icons = {
                    passed = "✓",
                    running = "●",
                    failed = "✗",
                    skipped = "⊘",
                    unknown = "?",
                    watching = "👁",
                },
                floating = {
                    border = "rounded",
                    max_height = 0.8,
                    max_width = 0.9,
                },
                diagnostic = {
                    enabled = true,
                    severity = vim.diagnostic.severity.ERROR,
                },
            }
        end,
        config = function(_, opts)
            require("neotest").setup(opts)

            -- Автокоманды для Go тестов
            vim.api.nvim_create_autocmd("FileType", {
                pattern = "go",
                callback = function()
                    -- Дополнительные маппинги для Go файлов
                    vim.keymap.set("n", "<leader>tl", function()
                        require("neotest").run.run_last()
                    end, { buffer = true, desc = "Neotest: Run last test" })

                    vim.keymap.set("n", "<leader>tw", function()
                        require("neotest").watch.toggle()
                    end, { buffer = true, desc = "Neotest: Toggle watch mode" })
                end,
            })
        end,
    },
}
