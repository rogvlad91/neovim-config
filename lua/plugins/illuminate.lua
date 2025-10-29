return {
    {
        "RRethy/vim-illuminate",
        event = "BufReadPost",
        opts = {
            delay = 200,
            large_file_cutoff = 2000,
            large_file_overrides = {
                providers = { "lsp" },
            },
        },
        config = function(_, opts)
            require("illuminate").configure(opts)

            local function map(key, dir, buffer)
                vim.keymap.set("n", key, function()
                    require("illuminate")["goto_" .. dir .. "_reference"](false)
                end, { desc = "Illuminate: " .. dir:sub(1, 1):upper() .. dir:sub(2) .. " reference", buffer = buffer })
            end

            map("]]", "next")
            map("[[", "prev")

            -- Настройка подсветки при attach LSP
            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function(args)
                    local buffer = args.buf
                    map("]]", "next", buffer)
                    map("[[", "prev", buffer)
                end,
            })
        end,
        keys = {
            { "]]", desc = "Next reference" },
            { "[[", desc = "Prev reference" },
        },
    },
}
