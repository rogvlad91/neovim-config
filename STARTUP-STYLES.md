# Стили стартового экрана Neovim

## Как поменять стиль

Откройте файл `lua/plugins/alpha.lua` и замените строку с `dashboard.section.header.val` на один из вариантов ниже.

### Вариант 1: Текущий (DOOM стиль)
```lua
dashboard.section.header.val = require("config.ascii-art").doom
```

### Вариант 2: Fallout Pip-Boy
```lua
dashboard.section.header.val = require("config.ascii-art").pipboy
```

### Вариант 3: DOOM Slayer (агрессивный)
```lua
dashboard.section.header.val = require("config.ascii-art").slayer
```

### Вариант 4: Vault-Tec
```lua
dashboard.section.header.val = require("config.ascii-art").vault
```

### Вариант 5: Retro Terminal
```lua
dashboard.section.header.val = require("config.ascii-art").retro
```

### Вариант 6: Минималистичный DOOM
```lua
dashboard.section.header.val = require("config.ascii-art").mini_doom
```

## Цитаты

Вы можете добавить свои цитаты в массив `quotes` в файле `alpha.lua`:

```lua
local quotes = {
    "Ваша цитата здесь",
    "И еще одна",
}
```

## Цвета

Измените цветовую схему (по умолчанию зеленая в стиле Pip-Boy):

```lua
dashboard.section.header.opts.hl = "String"    -- Зеленый
-- или
dashboard.section.header.opts.hl = "Error"     -- Красный
dashboard.section.header.opts.hl = "Function"  -- Голубой
dashboard.section.header.opts.hl = "Keyword"   -- Фиолетовый
```

## Горячие клавиши на стартовом экране

- `f` - Find file (поиск файлов)
- `n` - New file (новый файл)
- `r` - Recent files (недавние файлы)
- `g` - Find text (поиск по тексту)
- `c` - Config (открыть конфигурацию)
- `s` - Restore Session (восстановить сессию)
- `l` - Lazy (менеджер плагинов)
- `q` - Quit (выход)

## Управление сессиями

- `<leader>qs` - Восстановить сессию для текущей директории
- `<leader>ql` - Восстановить последнюю сессию
- `<leader>qd` - Не сохранять текущую сессию при выходе

Сессии автоматически сохраняются при выходе из Neovim.
