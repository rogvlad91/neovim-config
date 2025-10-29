return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = {
        "nvim-lua/plenary.nvim",
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "make",
        },
    },
    cmd = "Telescope",
    keys = {
        { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Telescope: Find files" },
        { "<leader>fs", "<cmd>Telescope live_grep<cr>", desc = "Telescope: Live grep" },
        { "<leader>gr", "<cmd>Telescope lsp_references<cr>", desc = "Telescope: LSP references" },
        { "<leader>gi", "<cmd>Telescope lsp_implementations<cr>", desc = "Telescope: LSP implementations" },
        { "<leader>gd", "<cmd>Telescope lsp_definitions<cr>", desc = "Telescope: LSP definitions" },
        { "<leader>gy", "<cmd>Telescope lsp_type_definitions<cr>", desc = "Telescope: LSP type definitions" },
        { "<leader>gU", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Telescope: Document symbols" },
        {
            "<leader>fws",
            function()
                require("telescope.builtin").grep_string({ search = vim.fn.expand("<cword>") })
            end,
            desc = "Telescope: Search word under cursor"
        },
        {
            "<leader>fWs",
            function()
                require("telescope.builtin").grep_string({ search = vim.fn.expand("<cWORD>") })
            end,
            desc = "Telescope: Search WORD under cursor"
        },
    },
    config = function()
        require("telescope").load_extension("fzf")
    end,
}
