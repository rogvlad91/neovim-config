return {
    {
        "rafamadriz/friendly-snippets",
        event = "InsertEnter",
        dependencies = { "L3MON4D3/LuaSnip" },
        config = function()
            -- Загрузка сниппетов из friendly-snippets в формате VSCode
            require("luasnip.loaders.from_vscode").lazy_load()

            -- Дополнительная настройка LuaSnip
            local luasnip = require("luasnip")
            luasnip.config.set_config({
                history = true,
                updateevents = "TextChanged,TextChangedI",
                enable_autosnippets = true,
            })

            -- Дополнительные маппинги для навигации по сниппетам (если Tab не работает)
            vim.keymap.set({"i", "s"}, "<C-l>", function()
                if luasnip.expand_or_jumpable() then
                    luasnip.expand_or_jump()
                end
            end, { silent = true, desc = "LuaSnip: Expand or jump forward" })

            vim.keymap.set({"i", "s"}, "<C-h>", function()
                if luasnip.jumpable(-1) then
                    luasnip.jump(-1)
                end
            end, { silent = true, desc = "LuaSnip: Jump backward" })

            vim.keymap.set({"i", "s"}, "<C-E>", function()
                if luasnip.choice_active() then
                    luasnip.change_choice(1)
                end
            end, { silent = true, desc = "LuaSnip: Cycle choices" })
        end,
    },
}
