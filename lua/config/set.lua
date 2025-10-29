-- Курсор
vim.opt.guicursor = ""

-- Строки
vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.cursorline = true

-- Табы
vim.opt.shiftwidth = 4 
vim.opt.tabstop = 4
vim.opt.smartindent = true
vim.opt.softtabstop = 4
vim.opt.expandtab = true

-- Не обрубать текст по размеру редактора
vim.opt.wrap = false

-- Отключить вимовские бэкапы для лучшей работы undotree
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- Поиск по regex
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- Поддержка цветов терминала
vim.opt.termguicolors = true

-- Отступ от верхнего края редактора
vim.opt.scrolloff = 10
vim.opt.isfname:append("@-@")

-- Апдейты
vim.opt.updatetime = 50

-- Специальные настройки для hover
vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
  vim.lsp.handlers.hover, {
    border = 'rounded',
    style = 'minimal',
    focusable = true,
    max_width = 80,
    max_height = 30,
    -- Явное указание стилей
    close_events = { "CursorMoved", "BufHidden", "InsertCharPre" },
    focus = false,
    -- Дополнительные параметры отображения
    zindex = 50, -- Увеличьте это значение, если окна перекрываются
  }
)

-- Жёсткая установка непрозрачного фона для всех плавающих окон
vim.api.nvim_set_hl(0, 'NormalFloat', { bg = '#1e222a', blend = 0 })
vim.api.nvim_set_hl(0, 'FloatBorder', { bg = '#1e222a', fg = '#5d626b' })
vim.api.nvim_set_hl(0, 'Pmenu', { bg = '#1e222a', blend = 0 })
vim.api.nvim_set_hl(0, 'PmenuSel', { bg = '#3e4452', fg = 'white' })
vim.api.nvim_set_hl(0, 'PmenuSbar', { bg = '#1e222a' })
vim.api.nvim_set_hl(0, 'PmenuThumb', { bg = '#5d626b' })

-- Для документации cmp
vim.api.nvim_set_hl(0, 'CmpDocumentation', { bg = '#1e222a' })
vim.api.nvim_set_hl(0, 'CmpDocumentationBorder', { bg = '#1e222a', fg = '#1e222a' })
