return {
    {
        "goolord/alpha-nvim",
        event = "VimEnter",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            local alpha = require("alpha")
            local dashboard = require("alpha.themes.dashboard")

            -- ASCII Art в стиле DOOM/Fallout
            dashboard.section.header.val = require("config.ascii-art").pipboy
            -- Кастомный футер в стиле Fallout
            local function footer()
                local total_plugins = #vim.tbl_keys(require("lazy").plugins())
                local datetime = os.date(" %d-%m-%Y   %H:%M:%S")
                local version = vim.version()
                local nvim_version_info = "   v" .. version.major .. "." .. version.minor .. "." .. version.patch

                return "┃ " ..
                total_plugins .. " plugins loaded" .. " ┃ " .. datetime .. " ┃" .. nvim_version_info .. " ┃"
            end

            dashboard.section.footer.val = footer()

            -- Кнопки в стиле терминала
            dashboard.section.buttons.val = {
                dashboard.button("f", "  Find file", ":Telescope find_files <CR>"),
                dashboard.button("n", "  New file", ":ene <BAR> startinsert <CR>"),
                dashboard.button("r", "  Recent files", ":Telescope oldfiles <CR>"),
                dashboard.button("g", "  Find text", ":Telescope live_grep <CR>"),
                dashboard.button("c", "  Config", ":e $MYVIMRC <CR>"),
                dashboard.button("s", "  Restore Session", [[:lua require("persistence").load() <cr>]]),
                dashboard.button("l", "󰒲  Lazy", ":Lazy<CR>"),
                dashboard.button("q", "  Quit", ":qa<CR>"),
            }

            -- Случайные цитаты в стиле DOOM/Fallout
            local quotes = {
                "War. War never changes.",
                "Rip and tear, until it is done.",
                "In the first age, in the first battle...",
                "They are rage, brutal, without mercy.",
                "Against all the evil that Hell can conjure...",
                "I'm going to rip and tear!",
                "Vault-Tec: Preparing for the future.",
                "Please stand by...",
                "S.P.E.C.I.A.L: Strength, Perception, Endurance...",
                "It's dangerous to go alone! Take this.",
            }

            -- Случайная цитата под хедером
            math.randomseed(os.time())
            local quote = quotes[math.random(#quotes)]
            dashboard.section.header.val = vim.list_extend(dashboard.section.header.val, {
                "",
                "          [ " .. quote .. " ]",
                "",
            })

            -- Стилизация в стиле Pip-Boy (зеленый цвет)
            dashboard.section.header.opts.hl = "String"
            dashboard.section.buttons.opts.hl = "Keyword"
            dashboard.section.footer.opts.hl = "Type"

            -- Настройка отступов
            dashboard.opts.layout = {
                { type = "padding", val = 2 },
                dashboard.section.header,
                { type = "padding", val = 2 },
                dashboard.section.buttons,
                { type = "padding", val = 1 },
                dashboard.section.footer,
            }

            -- Отключить tabline и statusline на стартовом экране
            vim.api.nvim_create_autocmd("User", {
                pattern = "AlphaReady",
                callback = function()
                    vim.opt.showtabline = 0
                end,
            })

            vim.api.nvim_create_autocmd("BufUnload", {
                buffer = 0,
                callback = function()
                    vim.opt.showtabline = 2
                end,
            })

            alpha.setup(dashboard.opts)

            -- Открывать Alpha при закрытии последнего буфера
            vim.api.nvim_create_autocmd("User", {
                pattern = "BDeletePost*",
                callback = function(event)
                    local fallback_name = vim.api.nvim_buf_get_name(event.buf)
                    local fallback_ft = vim.api.nvim_buf_get_option(event.buf, "filetype")
                    local fallback_on_empty = fallback_name == "" and fallback_ft == ""

                    if fallback_on_empty then
                        vim.cmd("Alpha")
                        vim.cmd(event.buf .. "bwipeout")
                    end
                end,
            })
        end,
    },
}
