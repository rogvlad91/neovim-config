# Использование сниппетов в Neovim

## Как работают сниппеты

После обновления конфигурации у вас есть несколько способов использования сниппетов:

### Способ 1: Tab (рекомендуется)

В insert mode:
1. Начните вводить триггер сниппета (например, `ife`, `fn`, `for`)
2. Появится меню автодополнения nvim-cmp
3. Нажмите **Tab** чтобы:
   - Если меню открыто → выбрать следующий вариант
   - Если выбран сниппет → раскрыть его
   - Если вы внутри сниппета → перейти к следующему placeholder
4. Нажмите **Shift+Tab** для перехода к предыдущему placeholder

### Способ 2: Ctrl+L / Ctrl+H (альтернатива)

Если Tab конфликтует с другими плагинами:
- **Ctrl+L** - раскрыть сниппет или перейти к следующему placeholder
- **Ctrl+H** - вернуться к предыдущему placeholder
- **Ctrl+E** - переключаться между вариантами выбора (если есть)

### Способ 3: Ctrl+Space

1. Начните вводить триггер сниппета
2. Нажмите **Ctrl+Space** для принудительного вызова автодополнения
3. Выберите сниппет стрелками и нажмите **Enter**

## Популярные Go сниппеты

### Базовые конструкции

```go
// main - создать main функцию
main

// fn - создать функцию
fn

// met - создать метод
met

// pkgm - создать package main
pkgm
```

### Условия и циклы

```go
// if - if statement
if

// ife - if err != nil
ife

// iferr - if err != nil с return
iferr

// for - for loop
for

// fori - for с индексом
fori

// forr - for range
forr
```

### Структуры и интерфейсы

```go
// st - struct
st

// int - interface
int

// in - interface с методом
in

// tys - type struct
tys
```

### Тесты

```go
// test - table driven test
test

// tf - test function
tf

// tb - test benchmark
tb

// te - test example
te
```

### Ошибки и отладка

```go
// iferr - if err != nil return err
iferr

// errn - create new error
errn

// print - fmt.Println
print

// printf - fmt.Printf
printf

// log - log.Println
log
```

## Примеры использования

### Пример 1: if err != nil

1. Напишите `ife` в insert mode
2. Нажмите **Tab** или **Ctrl+L**
3. Получите:
```go
if err != nil {

}
```

### Пример 2: Создание функции

1. Напишите `fn` в insert mode
2. Нажмите **Tab** или **Ctrl+L**
3. Получите:
```go
func name(params) return {

}
```
4. Используйте **Tab** для перехода между `name`, `params`, `return`

### Пример 3: For range loop

1. Напишите `forr` в insert mode
2. Нажмите **Tab** или **Ctrl+L**
3. Получите:
```go
for key, value := range collection {

}
```
4. Используйте **Tab** для редактирования `key`, `value`, `collection`

## Отладка

Если сниппеты не работают:

1. Проверьте, что плагины установлены:
   ```vim
   :Lazy
   ```
   Должны быть установлены:
   - LuaSnip
   - friendly-snippets
   - cmp_luasnip

2. Проверьте, что LuaSnip загружен:
   ```vim
   :lua print(vim.inspect(require('luasnip')))
   ```

3. Посмотрите доступные сниппеты для Go:
   ```vim
   :lua require('luasnip').available()
   ```

4. Перезагрузите конфигурацию:
   ```vim
   :source $MYVIMRC
   ```
   Или перезапустите Neovim

## Горячие клавиши

| Режим | Клавиша | Действие |
|-------|---------|----------|
| i, s  | `Tab` | Раскрыть сниппет / Следующий placeholder |
| i, s  | `Shift+Tab` | Предыдущий placeholder |
| i, s  | `Ctrl+L` | Раскрыть сниппет / Следующий placeholder (альт.) |
| i, s  | `Ctrl+H` | Предыдущий placeholder (альт.) |
| i, s  | `Ctrl+E` | Переключить варианты выбора |
| i     | `Ctrl+Space` | Открыть меню автодополнения |

## Создание собственных сниппетов

Создайте файл `~/.config/nvim/snippets/go.json`:

```json
{
  "Custom snippet": {
    "prefix": "custom",
    "body": [
      "// Custom code",
      "${1:placeholder}",
      "$0"
    ],
    "description": "My custom snippet"
  }
}
```

Затем загрузите его в `lua/plugins/snippets.lua`:

```lua
require("luasnip.loaders.from_vscode").lazy_load({ paths = { "~/.config/nvim/snippets" } })
```
