return {
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "rcarriga/nvim-dap-ui",
            "theHamsta/nvim-dap-virtual-text",
            "leoluz/nvim-dap-go",
            "nvim-neotest/nvim-nio",
        },
        config = function()
            require("dap-go").setup()
            local dapui = require("dapui")

            require("dapui").setup()
            require("nvim-dap-virtual-text").setup()

            local dap = require "dap"

            dap.adapters.go = {
                type = "server",
                port = "40000",
                host = "127.0.0.1",
                -- executable = {
                --     command = "dlv",
                --     args = { "connect","127.0.0.1:40000" },
                -- },
            }

            vim.keymap.set("n", "<F1>", dap.continue, { desc = "DAP: Continue" })
            vim.keymap.set("n", "<leader>si", dap.step_into, { desc = "DAP: Step into" })
            vim.keymap.set("n", "<leader>sv", dap.step_over, { desc = "DAP: Step over" })
            vim.keymap.set("n", "<leader>so", dap.step_out, { desc = "DAP: Step out" })
            vim.keymap.set("n", "<leader>sb", dap.step_back, { desc = "DAP: Step back" })
            vim.keymap.set("n", "<leader>sr", dap.restart, { desc = "DAP: Restart" })
            vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint, { desc = "DAP: Toggle breakpoint" })
            vim.keymap.set("n", "<leader>db", dap.run_to_cursor, { desc = "DAP: Run to cursor" })
            vim.keymap.set("n", "<leader>dt", dapui.toggle, { desc = "DAP: Toggle UI" })
            vim.keymap.set("n", "<leader>?", function()
                require("dapui").eval(nil, { enter = true })
            end, { desc = "DAP: Eval under cursor" })
        end
    }
}
