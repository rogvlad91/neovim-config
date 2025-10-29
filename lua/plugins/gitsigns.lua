return {
    {
        "lewis6991/gitsigns.nvim",
        opts = {
            signs = {
                add          = { text = '+' },
                change       = { text = '-' },
                delete       = { text = '_' },
                topdelete    = { text = '‾' },
                changedelete = { text = '~' },
                untracked    = { text = '┆' },
            },
            signcolumn = true,
            numhl      = false,
            linehl     = false,
            word_diff  = false,
            watch_gitdir = { follow_files = true },
            auto_attach = true,
            attach_to_untracked = false,
            current_line_blame = false,
            current_line_blame_opts = {
                virt_text = true,
                virt_text_pos = 'eol',
                delay = 1000,
                ignore_whitespace = false,
                virt_text_priority = 100,
            },
            current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
            sign_priority = 6,
            update_debounce = 100,
            status_formatter = nil,
            max_file_length = 40000,
            preview_config = {
                border = 'single',
                style = 'minimal',
                relative = 'cursor',
                row = 0,
                col = 1
            },
            on_attach = function(bufnr)
                local gs = package.loaded.gitsigns

                local function map(mode, lhs, rhs, opts)
                    opts = opts or {}
                    opts.buffer = bufnr
                    vim.keymap.set(mode, lhs, rhs, opts)
                end

                -- Navigation
                map('n', '<leader>hn', function()
                    if vim.wo.diff then return ']c' end
                    vim.schedule(function() gs.next_hunk() end)
                    return '<Ignore>'
                end, {expr=true, desc = "Next Git hunk"})
                map('n', '<leader>hp', function()
                    if vim.wo.diff then return '[c' end
                    vim.schedule(function() gs.prev_hunk() end)
                    return '<Ignore>'
                end, {expr=true, desc = "Previous Git hunk"})

                -- Actions
                map('n', '<leader>hs', gs.stage_hunk, { desc = "Stage current hunk" })
                map('n', '<leader>hr', gs.reset_hunk, { desc = "Reset current hunk" })
                map('v', '<leader>hs', function() gs.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end, { desc = "Stage visual selection hunk" })
                map('v', '<leader>hr', function() gs.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end, { desc = "Reset visual selection hunk" })
                map('n', '<leader>hu', gs.undo_stage_hunk, { desc = "Undo stage hunk" })
                map('n', '<leader>hR', gs.reset_buffer, { desc = "Reset entire buffer" })
                map('n', '<leader>hh', gs.preview_hunk, { desc = "Preview hunk changes" })
                map('n', '<leader>hb', function() gs.blame_line{full=true} end, { desc = "Blame current line" })
                map('n', '<leader>tb', gs.toggle_current_line_blame, { desc = "Toggle current line blame" })
                map('n', '<leader>hd', gs.diffthis, { desc = "Diff this hunk/file" })
                map('n', '<leader>hD', function() gs.diffthis('~') end, { desc = "Diff against last commit" })
                map('n', '<leader>td', gs.toggle_deleted, { desc = "Toggle deleted lines" })

                -- Text object
                map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { desc = "Select hunk text object" })
            end
        }
    }
}

