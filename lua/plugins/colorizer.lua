return {
    {
        "norcalli/nvim-colorizer.lua",
        event = "BufReadPost",
        config = function()
            require("colorizer").setup({
                "*", -- Highlight all files
                css = { rgb_fn = true }, -- Enable parsing rgb(...) functions in css
                html = { names = false }, -- Disable parsing "names" like Blue in html files
            }, {
                RGB = true, -- #RGB hex codes
                RRGGBB = true, -- #RRGGBB hex codes
                names = true, -- "Name" codes like Blue
                RRGGBBAA = true, -- #RRGGBBAA hex codes
                rgb_fn = true, -- CSS rgb() and rgba() functions
                hsl_fn = true, -- CSS hsl() and hsla() functions
                css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
                css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
                mode = "background", -- Set the display mode (foreground/background)
            })
        end,
    },
}
