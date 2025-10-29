return {
    'akinsho/git-conflict.nvim',
    version = "*",
    config = function()
        require('git-conflict').setup({
            default_mappings = false,
            disable_diagnostics = true,
        })

        -- Устанавливаем маппинги с описаниями
        vim.keymap.set('n', '<leader>go', '<Plug>(git-conflict-ours)', { desc = "Git Conflict: Choose ours" })
        vim.keymap.set('n', '<leader>gt', '<Plug>(git-conflict-theirs)', { desc = "Git Conflict: Choose theirs" })
        vim.keymap.set('n', '<leader>gn', '<Plug>(git-conflict-none)', { desc = "Git Conflict: Choose none" })
        vim.keymap.set('n', '<leader>gb', '<Plug>(git-conflict-both)', { desc = "Git Conflict: Choose both" })
        vim.keymap.set('n', ']x', '<Plug>(git-conflict-next-conflict)', { desc = "Git Conflict: Next conflict" })
        vim.keymap.set('n', '[x', '<Plug>(git-conflict-prev-conflict)', { desc = "Git Conflict: Previous conflict" })
    end
}
