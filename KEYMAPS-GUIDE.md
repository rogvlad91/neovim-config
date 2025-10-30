# Руководство по поиску и использованию keymaps

## 🎯 Два способа найти команду

У вас установлено два плагина для работы с keymaps:
1. **which-key.nvim** - пассивные подсказки при наборе
2. **legendary.nvim** - активный поиск команд (Command Palette)

---

## 1️⃣ which-key.nvim - Подсказки при наборе

### Как работает:

Просто начните нажимать клавиши - через 500ms появится окно с подсказками.

### Пример:

```vim
Нажимаете: <Space> (leader key)
Ждете 500ms...

Появляется окно:
╭─────────────────────────────────────╮
│ 󰍉 Find (Telescope)     <leader>f   │
│  Git                    <leader>g   │
│ 󰙨 Test (Neotest)       <leader>t   │
│  Debug/Database        <leader>d   │
│ 󰓩 Buffer               <leader>b   │
│  Code/Coverage         <leader>c   │
│  Git Hunk              <leader>h   │
│  LSP                   <leader>v   │
│  Trouble               <leader>x   │
╰─────────────────────────────────────╯

Нажимаете: f (для Find)

Появляется подменю:
╭─────────────────────────────────────╮
│  Find files            <leader>ff  │
│  Live grep             <leader>fs  │
│  Find todos            <leader>ft  │
│  Word under cursor     <leader>fws │
╰─────────────────────────────────────╯
```

### Основные группы:

| Префикс | Группа | Иконка |
|---------|--------|--------|
| `<leader>f` | Find (Telescope) | 󰍉 |
| `<leader>g` | Git |  |
| `<leader>t` | Test (Neotest) | 󰙨 |
| `<leader>d` | Debug/Database |  |
| `<leader>b` | Buffer | 󰓩 |
| `<leader>c` | Code/Coverage |  |
| `<leader>h` | Git Hunk |  |
| `<leader>v` | LSP |  |
| `<leader>x` | Trouble |  |
| `<leader>n` | Notify | 󰎚 |
| `<leader>s` | Search/Replace |  |
| `[` | Previous |  |
| `]` | Next |  |

### Специальные команды:

```vim
<leader>?        " Показать keymaps для текущего буфера
<leader><leader> " Показать ВСЕ keymaps
```

### Навигация по brackets:

```vim
[  " Показать все "Previous" команды
   [t  - Previous todo
   [x  - Previous git conflict
   [c  - Previous git change
   [d  - Previous diagnostic

]  " Показать все "Next" команды
   ]t  - Next todo
   ]x  - Next git conflict
   ]c  - Next git change
   ]d  - Next diagnostic
```

---

## 2️⃣ legendary.nvim - Command Palette (VSCode style)

### Как работает:

Открываете palette и ищете команду через fuzzy search.

### Основные команды:

| Клавиша | Действие | Описание |
|---------|----------|----------|
| `<leader>p` | Legendary | Открыть Command Palette (все) |
| `<leader>P` | Legendary keymaps | Только keymaps |
| `<Ctrl-p>` | Legendary commands | Только команды |

### Пример использования:

#### Сценарий 1: "Хочу запустить тесты"

```vim
<leader>p
```

В Telescope появляется:
```
Legendary> test█

Results:
> 󰌌 Run nearest test              <leader>tt
  󰌌 Run test file                <leader>tf
  󰌌 Run all tests                <leader>ta
  󰌌 Debug nearest test           <leader>td
  󰌌 Toggle test summary          <leader>tS
   :GoTestFunc                   Test function under cursor
   :GoTestFile                   Test current file
```

Стрелками выбираете нужное → Enter → выполняется!

#### Сценарий 2: "Хочу показать coverage"

```vim
<leader>p
```

```
Legendary> cover█

Results:
> 󰌌 Toggle coverage              <leader>cc
  󰌌 Load coverage file          <leader>cl
  󰌌 Coverage summary            <leader>cs
   :GoCoverage                  Show test coverage
```

#### Сценарий 3: "Нужна база данных"

```vim
<leader>p
```

```
Legendary> db█

Results:
> 󰌌 Database: Toggle UI          <leader>db
  󰌌 Database: Add connection    <leader>dba
   :DBUIToggle                  Toggle database UI
   :DBUIFindBuffer             Find database buffer
```

#### Сценарий 4: "Только команды Vim"

```vim
<Ctrl-p>
```

```
Legendary> lazy█

Results:
>  :Lazy                        Open Lazy plugin manager
   :Lazy sync                   Sync plugins
   :Lazy update                 Update plugins
```

### Frecency (часто используемые команды)

Legendary запоминает какие команды вы используете чаще всего и показывает их выше в списке!

Пример:
```
После 10 запусков <leader>tt:

Legendary> █

Results:
> 󰌌 Run nearest test              <leader>tt    ⭐ (часто)
  󰌌 Database: Toggle UI          <leader>db    ⭐
  󰌌 Find files                   <leader>ff
  ...
```

---

## 🆚 Когда использовать which-key vs legendary

### Используйте which-key когда:

✅ Знаете префикс команды
- "Знаю что это `<leader>t`, но забыл что дальше"

✅ Учите новые команды
- Просто нажимайте префиксы и смотрите что доступно

✅ Исследуете новый плагин
- Установили плагин → нажмите `<leader>` → увидите его команды

### Используйте legendary когда:

✅ Знаете что хотите, но забыли как
- "Как запустить тесты?" → `<leader>p` → "test"

✅ Ищете команду по описанию
- "Мне нужен blame" → `<leader>p` → "blame"

✅ Не помните prefix
- Вместо `<leader>?что?там?дальше?` → `<leader>p` → fuzzy search

✅ Хотите найти Vim команду
- `<Ctrl-p>` → "mason" → `:Mason`

---

## 📚 Категории команд в legendary

Legendary автоматически группирует команды:

### Git Operations ( )
- `:Git` - LazyGit
- `:Gitsigns toggle_current_line_blame` - Toggle blame

### Testing (󰙨)
- `:Neotest summary` - Test summary
- `:Neotest output-panel` - Output panel
- `:GoTestFunc` - Test function (в Go файлах)
- `:GoTestFile` - Test file (в Go файлах)

### Database ()
- `:DBUIToggle` - Toggle UI
- `:DBUIFindBuffer` - Find buffer
- `:DBUIAddConnection` - Add connection

### System
- `:Lazy` - Plugin manager
- `:Mason` - LSP installer
- `:checkhealth` - Health check

---

## 💡 Практические примеры

### Утро понедельника, забыли все команды

```vim
" Вариант 1: Исследование через which-key
<Space>        " Смотрим что доступно
<Space>t       " Ага, тесты
<Space>tf      " Запускаем все тесты в файле

" Вариант 2: Поиск через legendary
<leader>p      " Открываем palette
"test file"    " Ищем
<Enter>        " Запускаем
```

### Отладка: нужно посмотреть БД

```vim
" which-key (если помните prefix)
<Space>d       " Debug/Database группа
<Space>db      " Database UI

" legendary (если не помните)
<leader>p
"database"     " Fuzzy search
<Enter>
```

### Работа с Git конфликтами

```vim
" which-key
<Space>g       " Git группа
<Space>go      " Choose ours

" legendary
<leader>p
"conflict ours"
<Enter>
```

### Найти команду в Telescope

```vim
" which-key
<Space>f       " Find группа
<Space>ff      " Find files

" legendary
<leader>p
"find files"   " Или просто "ff"
<Enter>
```

---

## 🎨 Как выглядят окна

### which-key (modern preset):

```
╭─────── Keymaps ───────╮
│                       │
│ 󰍉 f  Find            │
│  g  Git              │
│ 󰙨 t  Test            │
│  d  Debug/Database   │
│                       │
╰───────────────────────╯
```

### legendary (через Telescope):

```
╭────────────── Legendary ──────────────╮
│                                       │
│  Search: test█                        │
│                                       │
│  Results:                             │
│  > 󰌌 Run nearest test    <leader>tt   │
│    󰌌 Run test file       <leader>tf   │
│    󰌌 Debug test          <leader>td   │
│                                       │
╰───────────────────────────────────────╯
```

---

## 🔧 Настройка

### Изменить задержку which-key

Если 500ms слишком долго:

```lua
-- В lua/plugins/whichkey.lua
opts = {
    delay = 300, -- Было 500, стало 300ms
}
```

### Отключить frecency в legendary

```lua
-- В lua/plugins/legendary.lua
sort = {
    frecency = false, -- Отключить
}
```

### Добавить свои команды в legendary

```lua
-- В lua/plugins/legendary.lua, в config функции
require("legendary").commands({
    {
        ":MyCustomCommand",
        description = "My custom command description",
    },
})
```

---

## 🚀 Workflow рекомендации

### Для новичков:

1. **Используйте which-key для обучения**
   - Нажимайте `<Space>` и смотрите что доступно
   - Запоминайте группы команд

2. **Постепенно переходите на legendary**
   - Когда знаете что хотите - ищите через `<leader>p`

### Для опытных:

1. **which-key для редких команд**
   - Те что используете раз в месяц

2. **legendary для частых команд**
   - Frecency покажет их сверху
   - Быстрее чем вспоминать prefix

### Для микросервисов:

```vim
" Быстрый доступ к БД
<leader>p → "db" → Enter → Toggle UI

" Быстрый запуск тестов
<leader>p → "test file" → Enter

" Проверка coverage
<leader>p → "cover" → Enter
```

---

## 📊 Статистика и аналитика

### Популярные команды (будут сверху в legendary):

После недели использования legendary будет знать:
```
Ваши топ команды:
1. <leader>tt  - Run test         (20 раз)
2. <leader>db  - Database         (15 раз)
3. <leader>ff  - Find files       (12 раз)
4. <leader>cc  - Coverage         (8 раз)
```

### Где хранится статистика:

```
~/.local/share/nvim/legendary/
```

Можно очистить:
```bash
rm -rf ~/.local/share/nvim/legendary/
```

---

## 🐛 Troubleshooting

### which-key не показывается

```vim
:checkhealth which-key
```

Проверить delay:
```lua
delay = 100, -- Сделать меньше для тестирования
```

### legendary не находит команды

```vim
" Проверить что импортированы which-key команды
:Legendary

" Если пусто - проверить конфиг
:lua print(vim.inspect(require("legendary").get_commands()))
```

### Telescope не открывается в legendary

Убедитесь что Telescope установлен:
```vim
:Telescope
```

---

## 🎓 Обучение

### День 1: which-key

Просто работайте как обычно, нажимайте `<Space>` и смотрите подсказки.

### День 2-3: legendary для частых команд

Начните использовать `<leader>p` для команд которые часто используете:
- "test" → запуск тестов
- "db" → база данных
- "find" → поиск файлов

### День 4-7: Оптимизация

Смотрите какие команды используете чаще всего и запоминайте их shortcuts.

### Через неделю:

- Редкие команды → which-key (пассивно)
- Частые команды → мышечная память
- Забытые команды → legendary (активный поиск)

---

## 💎 Pro Tips

### 1. Комбо для новых плагинов

После установки нового плагина:
```vim
<leader><leader>  " Показать ВСЕ keymaps
" Найти новые команды в списке
```

### 2. Быстрый доступ к часто используемым

Создайте алиас в legendary:
```lua
commands = {
    { ":W", description = "Save file (alias)" },
}
```

### 3. Поиск по части слова

В legendary можете искать по любой части:
```
"near" → найдет "Run nearest test"
"summ" → найдет "Toggle test summary"
```

### 4. Visual mode в legendary

```vim
" Выделите текст в visual mode
viw
<leader>p
" Увидите команды доступные в visual mode
```

---

## 📝 Шпаргалка

```
WHICH-KEY (пассивные подсказки):
<Space>          - Показать главное меню
<Space>?         - Keymaps текущего буфера
<Space><Space>   - ВСЕ keymaps
[                - Previous команды
]                - Next команды

LEGENDARY (активный поиск):
<leader>p        - Command Palette (всё)
<leader>P        - Только keymaps
<Ctrl-p>         - Только команды
:Legendary       - Открыть palette
```

---

**Теперь у вас два мощных инструмента для навигации по командам! Попробуйте оба и используйте тот который удобнее в конкретной ситуации.** 🎉
