return {
    {
        "rcarriga/nvim-notify",
        event = "VeryLazy",
        opts = {
            timeout = 3000,
            max_height = function()
                return math.floor(vim.o.lines * 0.75)
            end,
            max_width = function()
                return math.floor(vim.o.columns * 0.75)
            end,
            stages = "fade_in_slide_out", -- Анимация появления
            render = "compact", -- Компактный вид
            background_colour = "#000000",
            top_down = false, -- Показывать снизу вверх
        },
        config = function(_, opts)
            local notify = require("notify")
            notify.setup(opts)

            -- Заменить стандартную функцию vim.notify
            vim.notify = notify

            -- Горячие клавиши
            vim.keymap.set("n", "<leader>nd", function()
                notify.dismiss({ silent = true, pending = true })
            end, { desc = "Notify: Dismiss all notifications" })

            vim.keymap.set("n", "<leader>nh", "<cmd>Telescope notify<cr>", { desc = "Notify: Show notification history" })
        end,
        keys = {
            {
                "<leader>nd",
                function()
                    require("notify").dismiss({ silent = true, pending = true })
                end,
                desc = "Notify: Dismiss all notifications",
            },
        },
    },
}
