return {
    {
        "axkirillov/hbac.nvim",
        event = "BufReadPre",
        opts = {
            autoclose = true, -- Автоматически закрывать неактивные буферы
            threshold = 10, -- Держать минимум 10 буферов открытыми
            close_command = function(bufnr)
                vim.api.nvim_buf_delete(bufnr, {})
            end,
            close_buffers_with_windows = false, -- Не закрывать буферы с окнами
        },
        keys = {
            { "<leader>bp", "<cmd>lua require('hbac').toggle_pin()<cr>", desc = "HBAC: Pin/Unpin buffer" },
            { "<leader>ba", "<cmd>lua require('hbac').close_unpinned()<cr>", desc = "HBAC: Close all unpinned buffers" },
        },
    },
}
