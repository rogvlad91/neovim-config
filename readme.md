# 🚀 Neovim Configuration - DOOM/Fallout Edition

Профессиональная конфигурация Neovim для Go разработки с интеграцией Claude AI, эпическим стартовым экраном и 52+ плагинами.

## 📋 Содержание

- [Установка](#установка)
- [Первый запуск](#первый-запуск)
- [Горячие клавиши](#горячие-клавиши)
- [Установленные плагины](#установленные-плагины)
- [Работа с Go](#работа-с-go)
- [Интеграция с Claude AI](#интеграция-с-claude-ai)
- [Навигация и поиск](#навигация-и-поиск)
- [Git интеграция](#git-интеграция)
- [LSP возможности](#lsp-возможности)
- [Отладка (DAP)](#отладка-dap)
- [Советы и трюки](#советы-и-трюки)

---

## 🛠 Установка

### Требования

- Neovim >= 0.8.0
- Git
- Node.js (для некоторых LSP серверов)
- Go (для разработки на Go)
- ripgrep (для поиска)
- fd (для быстрого поиска файлов)
- make (для telescope-fzf-native)

### macOS

```bash
brew install neovim ripgrep fd
```

### Первая установка

Конфигурация уже установлена в `~/.config/nvim/`. При первом запуске:

```bash
nvim
```

Lazy.nvim автоматически установит все плагины. Дождитесь завершения установки.

---

## 🎮 Первый запуск

После установки выполните:

```bash
# Установите LSP серверы
:Mason

# В интерфейсе Mason установите:
# - gopls (Go)
# - lua_ls (Lua)
# Или они установятся автоматически при открытии файлов

# Установите Claude CLI (опционально)
curl -fsSL https://claude.ai/install.sh | bash
claude login  # Авторизация через браузер
```

---

## ⌨️ Горячие клавиши

### Leader Key

`<Space>` - основная Leader клавиша

### Основные команды

#### Файлы и навигация

| Клавиша | Действие | Плагин |
|---------|----------|--------|
| `<leader>ff` | Найти файлы | Telescope |
| `<leader>fs` | Поиск по содержимому (Live Grep) | Telescope |
| `<leader>fws` | Искать слово под курсором | Telescope |
| `<leader>fWs` | Искать WORD под курсором (с символами) | Telescope |
| `<C-n>` | Открыть/закрыть файловый менеджер | NvimTree |
| `<leader>e` | Фокус на файловом менеджере | NvimTree |

#### Harpoon (быстрая навигация)

| Клавиша | Действие |
|---------|----------|
| `<leader>a` | Добавить файл в Harpoon |
| `<C-e>` | Открыть меню Harpoon |
| `<C-h>` | Перейти к файлу 1 |
| `<C-j>` | Перейти к файлу 2 |
| `<C-k>` | Перейти к файлу 3 |
| `<C-m>` | Перейти к файлу 4 |

#### LSP и код

| Клавиша | Действие |
|---------|----------|
| `K` | Показать документацию |
| `gd` | Перейти к определению |
| `<leader>gd` | Найти определения (Telescope) |
| `<leader>gr` | Найти использования |
| `<leader>gi` | Найти реализации |
| `<leader>gy` | Найти определения типов |
| `<leader>gU` | Символы документа |
| `<leader>rn` | Переименовать символ |
| `<leader>vca` | Действия кода |
| `<leader>fm` | Форматировать код |
| `[d` | Предыдущая диагностика |
| `]d` | Следующая диагностика |
| `<leader>dn` | Следующая диагностика |
| `<leader>dp` | Предыдущая диагностика |

#### Git

| Клавиша | Действие | Плагин |
|---------|----------|--------|
| `<leader>hn` | Следующий hunk | Gitsigns |
| `<leader>hp` | Предыдущий hunk | Gitsigns |
| `<leader>hs` | Stage hunk | Gitsigns |
| `<leader>hr` | Reset hunk | Gitsigns |
| `<leader>hu` | Undo stage hunk | Gitsigns |
| `<leader>hh` | Превью hunk | Gitsigns |
| `<leader>hb` | Показать blame | Gitsigns |
| `<leader>tb` | Переключить blame | Gitsigns |
| `<leader>hd` | Diff this | Gitsigns |
| `<leader>do` | Открыть Diffview | Diffview |
| `<leader>dc` | Закрыть Diffview | Diffview |
| `<leader>dh` | История файла | Diffview |
| `<leader>go` | Конфликт: выбрать ours | Git Conflict |
| `<leader>gt` | Конфликт: выбрать theirs | Git Conflict |
| `<leader>gb` | Конфликт: выбрать both | Git Conflict |
| `<leader>gn` | Конфликт: выбрать none | Git Conflict |

#### Отладка (DAP)

| Клавиша | Действие |
|---------|----------|
| `<F1>` | Продолжить/Запустить |
| `<leader>si` | Step Into |
| `<leader>sv` | Step Over |
| `<leader>so` | Step Out |
| `<leader>sb` | Step Back |
| `<leader>sr` | Restart |
| `<leader>b` | Toggle Breakpoint |
| `<leader>db` | Run to Cursor |
| `<leader>dt` | Toggle DAP UI |
| `<leader>?` | Evaluate expression |

#### Буферы и вкладки

| Клавиша | Действие |
|---------|----------|
| `<Tab>` | Следующий буфер |
| `<Shift-Tab>` | Предыдущий буфер |
| `<leader>x` | Закрыть текущий буфер |
| `<leader>X` | Закрыть остальные буферы |

#### Редактирование

| Клавиша | Действие | Режим |
|---------|----------|-------|
| `<leader>p` | Вставить без затирания регистра | Visual |
| `<leader>y` | Копировать в системный буфер | Normal/Visual |
| `<leader>Y` | Копировать до конца строки | Normal |
| `<leader>s` | Поиск и замена слова под курсором | Normal |
| `gc` | Закомментировать | Normal/Visual |
| `gcc` | Закомментировать строку | Normal |

#### Mini.surround (окружения)

| Клавиша | Действие |
|---------|----------|
| `sa` | Add surrounding |
| `sd` | Delete surrounding |
| `sr` | Replace surrounding |
| `sf` | Find surrounding (right) |
| `sF` | Find surrounding (left) |
| `sh` | Highlight surrounding |

Примеры:
- `saiw"` - окружить слово кавычками
- `sd"` - удалить окружающие кавычки
- `sr"'` - заменить " на '

#### Flash.nvim (быстрая навигация)

| Клавиша | Действие | Режим |
|---------|----------|-------|
| `s` | Jump (прыжок по 2 символам) | Normal/Visual/Operator |
| `S` | Treesitter jump | Normal/Visual/Operator |
| `r` | Remote flash | Operator |
| `R` | Treesitter search | Operator/Visual |

#### Illuminate (подсветка символов)

| Клавиша | Действие |
|---------|----------|
| `]]` | Следующее вхождение символа |
| `[[` | Предыдущее вхождение символа |

#### Trouble (диагностика)

| Клавиша | Действие |
|---------|----------|
| `<leader>xx` | Открыть диагностику |
| `<leader>xX` | Диагностика буфера |
| `<leader>xs` | Symbols |
| `<leader>xl` | LSP references |
| `<leader>xL` | Location list |
| `<leader>xQ` | Quickfix list |

#### TODO Comments

| Клавиша | Действие |
|---------|----------|
| `<leader>ft` | Найти все TODO в проекте |
| `]t` | Следующий TODO |
| `[t` | Предыдущий TODO |

#### TreesitterContext

| Клавиша | Действие |
|---------|----------|
| `<leader>tc` | Переключить контекст функции |

#### Claude AI

| Клавиша | Действие |
|---------|----------|
| `<leader>cc` | Открыть Claude Code терминал |
| `<leader>cf` | Фокус на Claude |
| `<leader>cm` | Выбрать модель Claude |
| `<leader>cs` | Отправить выделение Claude |

#### Сессии

| Клавиша | Действие |
|---------|----------|
| `<leader>qs` | Восстановить сессию |
| `<leader>ql` | Последняя сессия |
| `<leader>qd` | Не сохранять сессию |

#### Утилиты

| Клавиша | Действие |
|---------|----------|
| `<leader>u` | Открыть Undotree |
| `<leader>l` | Переключить LSP lines |
| `<leader>rs` | Rip substitute (продвинутая замена) |
| `<leader>?` | Which-key для буфера |
| `<leader>j/k` | Quickfix next/prev |

---

## 📦 Установленные плагины

### Менеджер плагинов
- **lazy.nvim** - современный менеджер плагинов

### LSP и автодополнение
- **lsp-zero.nvim** - упрощенная настройка LSP
- **nvim-lspconfig** - конфигурации LSP серверов
- **mason.nvim** - установщик LSP/DAP серверов
- **mason-lspconfig.nvim** - интеграция Mason и LSP
- **nvim-cmp** - автодополнение
- **cmp-nvim-lsp** - источник LSP для автодополнения
- **LuaSnip** - движок сниппетов
- **friendly-snippets** - коллекция готовых сниппетов
- **none-ls.nvim** - форматтеры и линтеры

### Навигация и поиск
- **telescope.nvim** - fuzzy finder
- **telescope-fzf-native.nvim** - ускорение поиска
- **nvim-tree.lua** - файловый менеджер
- **harpoon** - быстрая навигация между файлами
- **flash.nvim** - прыжки по коду

### Go разработка
- **go.nvim** - утилиты для Go
- **nvim-dap-go** - отладка Go кода

### Git интеграция
- **gitsigns.nvim** - знаки и hunks
- **git-blame.nvim** - inline blame
- **git-conflict.nvim** - разрешение конфликтов
- **diffview.nvim** - просмотр diff

### UI и визуализация
- **rose-pine** - цветовая схема
- **lualine.nvim** - статус-бар
- **bufferline.nvim** - табы буферов
- **alpha-nvim** - стартовый экран
- **which-key.nvim** - подсказки горячих клавиш
- **indent-blankline.nvim** - визуализация отступов
- **nvim-colorizer.lua** - подсветка цветов
- **vim-illuminate** - подсветка одинаковых слов
- **nvim-treesitter-context** - контекст функции
- **lsp-lines.nvim** - диагностика в виде линий
- **symbol-usage.nvim** - индикаторы использования
- **noice.nvim** - улучшенный UI сообщений
- **nvim-web-devicons** - иконки

### Редактирование
- **Comment.nvim** - комментирование
- **nvim-autopairs** - автозакрытие скобок
- **mini.surround** - работа с окружениями
- **nvim-rip-substitute** - продвинутая замена
- **undotree** - визуализация истории изменений

### Утилиты
- **todo-comments.nvim** - подсветка TODO/FIXME
- **trouble.nvim** - улучшенная диагностика
- **persistence.nvim** - сохранение сессий
- **snacks.nvim** - терминал и утилиты

### Отладка
- **nvim-dap** - протокол отладки
- **nvim-dap-ui** - UI для отладки
- **nvim-dap-virtual-text** - виртуальный текст для DAP

### Синтаксис
- **nvim-treesitter** - парсинг и подсветка синтаксиса

### Claude AI
- **claudecode.nvim** - интеграция с Claude Code

---

## 🐹 Работа с Go

### LSP возможности

После открытия Go файла автоматически активируется gopls с:
- Автодополнением
- Проверкой типов
- Статическим анализом
- Рефакторингом

### Форматирование

Используются три форматтера:
- **gofumpt** - строгое форматирование
- **goimports_reviser** - упорядочивание импортов
- **golines** - контроль длины строк

Форматирование: `<leader>fm`

### Go команды (go.nvim)

```vim
:GoImport <package>        " Добавить import
:GoImpl <interface>        " Сгенерировать методы интерфейса
:GoFillStruct             " Заполнить поля структуры
:GoIfErr                  " Вставить if err != nil
:GoModTidy                " go mod tidy
:GoTest                   " Запустить тесты
:GoTestFunc               " Тест текущей функции
```

### Отладка Go кода

1. Поставьте breakpoint: `<leader>b`
2. Запустите отладку: `<F1>`
3. Используйте:
   - `<leader>si` - зайти в функцию
   - `<leader>sv` - перешагнуть
   - `<leader>so` - выйти из функции
4. Откройте DAP UI: `<leader>dt`

### Сниппеты для Go

Начните вводить и нажмите `Tab`:
- `fn` → функция
- `ife` → if err != nil
- `forr` → for range
- `struct` → структура
- `interface` → интерфейс
- `tf` → тестовая функция

---

## 🤖 Интеграция с Claude AI

### Настройка

1. Установите Claude CLI:
```bash
curl -fsSL https://claude.ai/install.sh | bash
```

2. Авторизуйтесь:
```bash
claude login
```
Откроется браузер для входа через аккаунт Anthropic.

3. Проверьте статус в Neovim:
```vim
:ClaudeCodeStatus
```

### Использование

- `<leader>cc` - Открыть чат с Claude
- `<leader>cs` - Отправить выделенный код Claude
- `<leader>cm` - Выбрать модель (Sonnet, Opus, Haiku)

В терминале Claude:
- Задавайте вопросы о коде
- Просите объяснить функции
- Генерируйте тесты
- Рефакторьте код

---

## 🔍 Навигация и поиск

### Telescope

**Базовый поиск:**
- `<leader>ff` - Найти файлы по имени
- `<leader>fs` - Найти по содержимому (ripgrep)

**LSP поиск:**
- `<leader>gd` - Определения
- `<leader>gr` - Использования
- `<leader>gi` - Реализации

**В интерфейсе Telescope:**
- `<C-n>/<C-p>` - Навигация
- `<CR>` - Открыть
- `<C-x>` - Открыть в split
- `<C-v>` - Открыть в vsplit
- `<C-t>` - Открыть в новой вкладке
- `<Esc>` - Закрыть

### Harpoon workflow

Harpoon позволяет быстро переключаться между 4 важными файлами:

1. Откройте первый файл → `<leader>a`
2. Откройте второй файл → `<leader>a`
3. Откройте третий файл → `<leader>a`
4. Откройте четвертый файл → `<leader>a`

Теперь:
- `<C-h>` - файл 1
- `<C-j>` - файл 2
- `<C-k>` - файл 3
- `<C-m>` - файл 4

Меню: `<C-e>` (добавить/удалить файлы)

### Flash.nvim

Быстрые прыжки по коду:

1. Нажмите `s`
2. Введите 2 символа куда хотите прыгнуть
3. Нажмите подсвеченную букву

Для Treesitter прыжков: `S`

---

## 📝 LSP возможности

### Автодополнение

При вводе автоматически появляется меню:
- `<Tab>` - следующий вариант
- `<Shift-Tab>` - предыдущий вариант
- `<Enter>` - выбрать
- `<C-Space>` - показать вручную

### Диагностика

Ошибки и предупреждения показываются:
- Inline в коде
- В статус-баре
- В Trouble (`:Trouble diagnostics`)

Навигация:
- `[d` / `]d` - предыдущая/следующая
- `<leader>xx` - открыть все в Trouble

### Рефакторинг

- `<leader>rn` - переименовать символ во всех местах
- `<leader>vca` - показать доступные действия
- `<leader>fm` - форматировать код

### Документация

- `K` - показать документацию под курсором
- `K` еще раз - войти в окно документации
- `<C-h>` (в insert mode) - показать сигнатуру функции

---

## 🐛 Отладка (DAP)

### Запуск отладки

1. Откройте Go файл с функцией `main`
2. Поставьте breakpoint: `<leader>b` на нужной строке
3. Запустите: `<F1>`

### Навигация по коду

- `<F1>` - продолжить выполнение
- `<leader>si` - зайти в функцию (step into)
- `<leader>sv` - перешагнуть (step over)
- `<leader>so` - выйти из функции (step out)

### UI отладки

`<leader>dt` - открыть/закрыть DAP UI с:
- Стеком вызовов
- Переменными
- Точками останова
- REPL для выполнения кода

### Точки останова

- `<leader>b` - переключить breakpoint
- `<leader>db` - запустить до курсора

### Оценка выражений

- `<leader>?` - оценить выражение под курсором
- В REPL можно выполнять любой Go код

---

## 💡 Советы и трюки

### 1. Быстрая навигация по проекту

Комбинируйте Telescope и Harpoon:
- Telescope для поиска новых файлов
- Harpoon для частоиспользуемых файлов
- Flash для прыжков внутри файла

### 2. Работа с TODO

Используйте комментарии:
```go
// TODO: реализовать обработку ошибок
// FIXME: исправить race condition
// HACK: временное решение
// NOTE: важная информация
```

Найти все: `<leader>ft`

### 3. Git workflow

```vim
" Посмотреть изменения
<leader>hn/hp  " навигация по hunkам
<leader>hh     " превью изменений

" Stage изменения
<leader>hs     " stage hunk
<leader>hu     " undo stage

" Просмотр истории
<leader>dh     " история файла
<leader>do     " diff view
```

### 4. Сессии для проектов

При работе с проектом сессия автоматически сохраняется:
```bash
cd ~/projects/myapp
nvim

# Работаете...
# При выходе сессия сохраняется

# На следующий день:
cd ~/projects/myapp
nvim
<leader>qs  # восстановить все буферы и вкладки
```

### 5. Множественный курсор

Используйте visual block mode:
1. `<C-v>` - visual block
2. Выделите столбец
3. `I` - вставка в начало
4. Введите текст
5. `<Esc>` - применить ко всем строкам

### 6. Поиск и замена

Быстрая замена слова:
1. Поставьте курсор на слово
2. `<leader>s`
3. Введите новое значение
4. `<Enter>`

Продвинутая замена:
- `<leader>rs` - rip-substitute с превью

### 7. Работа с буферами

```vim
:buffers        " список всех буферов
<Tab>          " следующий буфер
<S-Tab>        " предыдущий буфер
<leader>x      " закрыть текущий
<leader>X      " закрыть все кроме текущего
```

### 8. Split окна

```vim
:vsplit file.go  " вертикальный split
:split file.go   " горизонтальный split
<C-w>h/j/k/l    " навигация между окнами
<C-w>=          " выровнять размеры
<C-w>|          " максимизировать по ширине
<C-w>_          " максимизировать по высоте
```

### 9. Стартовый экран

При запуске без файла:
```bash
nvim           # стартовый экран
nvim file.go   # сразу открыть файл
```

Сменить ASCII art: см. `STARTUP-STYLES.md`

### 10. Обновление плагинов

```vim
:Lazy           " открыть Lazy UI
:Lazy update    " обновить все плагины
:Lazy sync      " синхронизировать с lazy-lock.json
```

---

## 📂 Структура конфигурации

```
~/.config/nvim/
├── init.lua                    # Точка входа
├── lazy-lock.json              # Фиксированные версии плагинов
├── README.md                   # Эта инструкция
├── STARTUP-STYLES.md          # Стили стартового экрана
├── lua/
│   ├── config/
│   │   ├── init.lua           # Загрузка конфигов
│   │   ├── set.lua            # Настройки Vim
│   │   ├── remap.lua          # Базовые горячие клавиши
│   │   ├── autocmds.lua       # Автокоманды
│   │   └── ascii-art.lua      # ASCII арты для стартового экрана
│   └── plugins/               # Конфигурации плагинов
│       ├── lsp.lua            # LSP настройка
│       ├── telescope.lua      # Поиск
│       ├── treesitter.lua     # Синтаксис
│       ├── alpha.lua          # Стартовый экран
│       ├── go.lua             # Go утилиты
│       ├── dap.lua            # Отладка
│       ├── gitsigns.lua       # Git интеграция
│       ├── harpoon.lua        # Быстрая навигация
│       ├── nvimtree.lua       # Файловый менеджер
│       ├── claudecode.lua     # Claude AI
│       └── ... (остальные плагины)
```

---

## 🆘 Решение проблем

### LSP не работает

```vim
:Mason                  " проверить установленные серверы
:LspInfo               " информация о LSP
:LspRestart            " перезапустить LSP
```

### Плагин не загружается

```vim
:Lazy                  " открыть Lazy UI
:Lazy reload <name>    " перезагрузить плагин
:Lazy clean            " удалить неиспользуемые
```

### Claude Code не подключается

```bash
# Проверить установку
which claude

# Проверить авторизацию
claude login

# В Neovim
:ClaudeCodeStatus
```

### Медленный старт

```vim
:Lazy profile          " профилирование загрузки
# Проверьте какие плагины загружаются долго
```

### Сбросить конфигурацию

```bash
# Бэкап
mv ~/.config/nvim ~/.config/nvim.backup
mv ~/.local/share/nvim ~/.local/share/nvim.backup

# Переустановка
nvim  # все установится заново
```

---

## 🎨 Кастомизация

### Сменить цветовую схему

В `lua/plugins/rosepine.lua` замените на:
```lua
require("rose-pine").setup({
    variant = "main"  -- "main", "moon", "dawn"
})
```

Или установите другую схему в `lua/plugins/`.

### Добавить свои горячие клавиши

В `lua/config/remap.lua`:
```lua
vim.keymap.set("n", "<leader>mc", "<cmd>MyCommand<cr>", { desc = "My custom command" })
```

### Добавить новый плагин

Создайте файл `lua/plugins/myplugin.lua`:
```lua
return {
    {
        "author/plugin-name",
        config = function()
            -- настройка
        end,
    },
}
```

Перезапустите Neovim - Lazy установит плагин автоматически.

---

## 📚 Ресурсы

- [Neovim документация](https://neovim.io/doc/)
- [Lazy.nvim](https://github.com/folke/lazy.nvim)
- [LSP Config](https://github.com/neovim/nvim-lspconfig)
- [Telescope](https://github.com/nvim-telescope/telescope.nvim)
- [Claude Code](https://claude.ai)

---

## 📝 Changelog

### v1.0 - Initial Release
- 52+ плагинов
- Полная поддержка Go
- LSP для Go и Lua
- Claude AI интеграция
- DOOM/Fallout стартовый экран
- DAP отладка
- Git интеграция

---

**Made with ❤️ and Claude Code**

*War. War never changes. But your coding experience will.* 🎮
