return {
    {
        "coder/claudecode.nvim",
        dependencies = { "folke/snacks.nvim" },
        cmd = {
            "ClaudeCode",
            "ClaudeCodeFocus",
            "ClaudeCodeSelectModel",
            "ClaudeCodeSend",
            "ClaudeCodeStatus",
        },
        keys = {
            { "<leader>cc", "<cmd>ClaudeCode<cr>", desc = "ClaudeCode: Open terminal" },
            { "<leader>cf", "<cmd>ClaudeCodeFocus<cr>", desc = "ClaudeCode: Focus" },
            { "<leader>cm", "<cmd>ClaudeCodeSelectModel<cr>", desc = "ClaudeCode: Select model" },
            { "<leader>cs", "<cmd>ClaudeCodeSend<cr>", mode = { "n", "v" }, desc = "ClaudeCode: Send selection" },
        },
        opts = {
            -- Если установлен локально, укажите путь:
            -- terminal_cmd = "~/.claude/local/claude"
        },
        config = true,
    },
}
