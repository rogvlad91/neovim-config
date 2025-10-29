return {
    {
        "nvim-treesitter/nvim-treesitter-context",
        event = "BufReadPost",
        dependencies = "nvim-treesitter/nvim-treesitter",
        opts = {
            enable = true,
            max_lines = 3,
            min_window_height = 0,
            line_numbers = true,
            multiline_threshold = 1,
            trim_scope = "outer",
            mode = "cursor",
            separator = nil,
        },
        keys = {
            {
                "<leader>tc",
                function()
                    require("treesitter-context").toggle()
                end,
                desc = "TreesitterContext: Toggle",
            },
        },
    },
}
