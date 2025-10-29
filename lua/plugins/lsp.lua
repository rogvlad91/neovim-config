return {
    {
        "VonHeikemen/lsp-zero.nvim",
        branch = "v2.x",
        dependencies = {
            "neovim/nvim-lspconfig",             -- Required
            "williamboman/mason.nvim",           -- Optional
            "williamboman/mason-lspconfig.nvim", -- Optional
            "hrsh7th/nvim-cmp",                  -- Required
            "hrsh7th/cmp-nvim-lsp",              -- Required
            "L3MON4D3/LuaSnip",                  -- Required
            "saadparwaiz1/cmp_luasnip",          -- LuaSnip completion source for nvim-cmp
            "nvimtools/none-ls.nvim",            -- Добавляем none-ls (ранее null-ls)
            "nvim-lua/plenary.nvim",             -- Зависимость для none-ls
        },
        config = function()
            local lsp = require("lsp-zero")
            lsp.preset("recommended")

            -- Настройка none-ls
            local null_ls = require("null-ls")

            -- Настройки cmp с поддержкой LuaSnip
            local cmp = require('cmp')
            local luasnip = require('luasnip')
            local cmp_select = { behavior = cmp.SelectBehavior.Select }

            local has_words_before = function()
                unpack = unpack or table.unpack
                local line, col = unpack(vim.api.nvim_win_get_cursor(0))
                return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
            end

            local cmp_mappings = lsp.defaults.cmp_mappings({
                ['<S-Tab>'] = cmp.mapping.select_prev_item(cmp_select),
                ['<Tab>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item(cmp_select)
                    elseif luasnip.expand_or_jumpable() then
                        luasnip.expand_or_jump()
                    elseif has_words_before() then
                        cmp.complete()
                    else
                        fallback()
                    end
                end, { "i", "s" }),
                ['<S-Tab>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item(cmp_select)
                    elseif luasnip.jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { "i", "s" }),
                ['<Enter>'] = cmp.mapping.confirm({ select = true }),
                ['<C-Space>'] = cmp.mapping.complete(),
            })

            lsp.set_preferences({
                sign_icons = {}
            })

            lsp.setup_nvim_cmp({
                preselect = 'item',
                completion = {
                    completeopt = 'menu,menuone,noinsert'
                },
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' },
                }, {
                    { name = 'buffer' },
                }),
                mapping = cmp_mappings,
            })

            -- Настройка форматтеров через none-ls
            null_ls.setup({
                sources = {
                    null_ls.builtins.formatting.gofumpt,
                    null_ls.builtins.formatting.goimports_reviser,
                    null_ls.builtins.formatting.golines,
                },
                on_attach = function(client, bufnr)
                    -- Если хотите, чтобы форматирование работало через <leader>fm
                    -- как в вашей текущей конфигурации
                end,
            })

            lsp.on_attach(function(client, bufnr)
                local opts = { buffer = bufnr, remap = false }
                vim.keymap.set("n", "<leader>fm", function()
                    vim.lsp.buf.format({
                        async = true,
                        -- Указываем, что хотим использовать все доступные форматтеры
                        filter = function(client)
                            -- Разрешаем форматирование от none-ls и других LSP,
                            -- которые поддерживают форматирование
                            return client.name == "null-ls" or client.supports_method("textDocument/formatting")
                        end
                    })
                end, vim.tbl_extend("force", opts, { desc = "LSP: Format" }))

                vim.keymap.set("v", "<leader>fm", function()
                    local start = vim.api.nvim_buf_get_mark(0, "<")
                    local finish = vim.api.nvim_buf_get_mark(0, ">")

                    vim.lsp.buf.format({
                        async = true,
                        filter = function(client)
                            return client.name == "null-ls" or client.supports_method("textDocument/rangeFormatting")
                        end,
                        range = {
                            start = { start[1], start[2] },
                            ["end"] = { finish[1], finish[2] },
                        }
                    })
                end, vim.tbl_extend("force", opts, { desc = "LSP: Format selection" }))

                vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, vim.tbl_extend("force", opts, { desc = "LSP: Hover documentation" }))
                vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, vim.tbl_extend("force", opts, { desc = "LSP: Workspace symbol" }))
                vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, vim.tbl_extend("force", opts, { desc = "LSP: Next diagnostic" }))
                vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, vim.tbl_extend("force", opts, { desc = "LSP: Previous diagnostic" }))
                vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, vim.tbl_extend("force", opts, { desc = "LSP: Code action" }))
                vim.keymap.set("n", "<leader>rn", function() vim.lsp.buf.rename() end, vim.tbl_extend("force", opts, { desc = "LSP: Rename" }))
                vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, vim.tbl_extend("force", opts, { desc = "LSP: Signature help" }))
            end)

            lsp.setup()

            local lspconfig = require("lspconfig")
            lspconfig.gopls.setup({
                settings = {
                    gopls = {
                        staticcheck = true,
                        completeUnimported = true,
                        analyses = {
                            unusedparams = false,
                            shadow = false,
                            metalinter = false
                        },
                        buildFlags = { "-tags=integration" },
                        codelenses = {
                            generate = false,
                            gc_details = false
                        }
                    }
                },
                on_attach = function(client, bufnr)
                    client.server_capabilities.documentFormattingProvider = false
                    client.server_capabilities.documentRangeFormattingProvider = false
                end
            })

            -- Lua LSP для разработки Neovim конфигов
            lspconfig.lua_ls.setup({
                settings = {
                    Lua = {
                        runtime = {
                            version = "LuaJIT",
                        },
                        diagnostics = {
                            globals = { "vim" },
                        },
                        workspace = {
                            library = vim.api.nvim_get_runtime_file("", true),
                            checkThirdParty = false,
                        },
                        telemetry = {
                            enable = false,
                        },
                        completion = {
                            callSnippet = "Replace",
                        },
                    },
                },
            })
        end
    }
}
