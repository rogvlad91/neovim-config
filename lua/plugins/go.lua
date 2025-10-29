return {
    {
        "ray-x/go.nvim",
        dependencies = { "ray-x/guihua.lua", "L3MON4D3/LuaSnip" },
        event = { "CmdlineEnter" },
        ft = { "go", "gomod" },
        build = ':lua require("go.install").update_all_sync()',
        config = function()
            require("go").setup({
                lsp_cfg = false,
                lsp_codelens = false,
                snippet_engine = "luasnip",
            })
        end,
    }
}
