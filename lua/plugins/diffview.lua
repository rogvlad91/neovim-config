return {
    {
        'sindrets/diffview.nvim',
        dependencies = 'nvim-lua/plenary.nvim',
        config = function()
            require('diffview').setup({
                view = {
                    merge_tool = {
                        layout = "diff3_mixed", -- LOCAL | BASE | REMOTE
                        disable_diagnostics = true,
                    }
                }
            })

            local map = vim.keymap.set
            -- Открыть общий diff
            map('n', '<leader>do', ':DiffviewOpen<CR>', { desc = "Diffview Open" })
            -- Закрыть diff
            map('n', '<leader>dc', ':DiffviewClose<CR>', { desc = "Diffview Close" })
            -- История текущего файла
            map('n', '<leader>dh', ':DiffviewFileHistory<CR>', { desc = "Diffview File History" })
            -- Открыть merge tool (при конфликтах)
            map('n', '<leader>dm', ':DiffviewOpen<CR>', { desc = "Diffview Merge Tool" })
        end
    }
}

