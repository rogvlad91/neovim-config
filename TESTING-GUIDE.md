# Тестирование Go проектов в Neovim

## Установленные плагины

- **neotest** - Фреймворк для запуска тестов
- **neotest-golang** - Адаптер для Go тестов
- **nvim-coverage** - Визуализация покрытия кода

## Горячие клавиши

### Запуск тестов

| Клавиша | Действие | Описание |
|---------|----------|----------|
| `<leader>tt` | Run Nearest | Запустить тест под курсором |
| `<leader>tf` | Run File | Запустить все тесты в файле |
| `<leader>ta` | Run All | Запустить весь test suite |
| `<leader>tl` | Run Last | Повторить последний тест |
| `<leader>ts` | Stop | Остановить выполнение |

### Отладка тестов

| Клавиша | Действие | Описание |
|---------|----------|----------|
| `<leader>td` | Debug Nearest | Отладить тест под курсором |

### Просмотр результатов

| Клавиша | Действие | Описание |
|---------|----------|----------|
| `<leader>to` | Show Output | Показать output теста |
| `<leader>tO` | Toggle Panel | Панель с результатами |
| `<leader>tS` | Toggle Summary | Дерево всех тестов |
| `]t` | Next Failed | Следующий failed тест |
| `[t` | Previous Failed | Предыдущий failed тест |

### Coverage (покрытие кода)

| Клавиша | Действие | Описание |
|---------|----------|----------|
| `<leader>cc` | Toggle Coverage | Показать/скрыть coverage |
| `<leader>cl` | Load Coverage | Загрузить coverage файл |
| `<leader>cs` | Coverage Summary | Показать статистику |
| `<leader>ch` | Hide Coverage | Скрыть coverage |

### Watch mode

| Клавиша | Действие | Описание |
|---------|----------|----------|
| `<leader>tw` | Toggle Watch | Auto-rerun при сохранении |

## Использование Neotest

### Базовый workflow

1. Откройте Go файл с тестами
2. Поставьте курсор на функцию теста
3. Нажмите `<leader>tt` - тест запустится
4. Посмотрите результат:
   - ✓ зеленая галочка = passed
   - ✗ красный крестик = failed
   - ⊘ = skipped

### Индикаторы в коде

Neotest показывает статус тестов:
- **Sign column** (слева от номеров строк): ✓ ✗ ⊘
- **Virtual text** (в конце строки): прямо в коде
- **Diagnostic** (подчеркивание): для failed тестов

### Summary (дерево тестов)

```vim
<leader>tS
```

Откроется дерево:
```
✓ myproject/
  ✓ user_test.go
    ✓ TestCreateUser
    ✗ TestUpdateUser
    ✓ TestDeleteUser
  ✗ order_test.go
    ✗ TestCreateOrder
```

Навигация:
- `<CR>` - перейти к тесту
- `o` - раскрыть/свернуть
- `r` - запустить тест
- `d` - отладить тест

### Output panel

```vim
<leader>tO
```

Показывает полный вывод всех тестов:
```
=== RUN   TestCreateUser
=== PAUSE TestCreateUser
=== CONT  TestCreateUser
--- PASS: TestCreateUser (0.00s)
PASS
```

## Типы тестов

### 1. Простой тест

```go
func TestAdd(t *testing.T) {
    result := Add(2, 3)
    if result != 5 {
        t.Errorf("Expected 5, got %d", result)
    }
}
```

Курсор на `TestAdd` → `<leader>tt`

### 2. Table-driven тесты

```go
func TestAdd(t *testing.T) {
    tests := []struct {
        name string
        a, b int
        want int
    }{
        {"positive", 2, 3, 5},
        {"negative", -1, -1, -2},
        {"zero", 0, 0, 0},
    }

    for _, tt := range tests {
        t.Run(tt.name, func(t *testing.T) {
            got := Add(tt.a, tt.b)
            if got != tt.want {
                t.Errorf("got %d, want %d", got, tt.want)
            }
        })
    }
}
```

**Возможности neotest-golang:**
- Курсор на `TestAdd` → запустит все sub-тесты
- Курсор на `t.Run("positive"` → запустит только "positive"

### 3. Вложенные тесты (nested)

```go
func TestUserService(t *testing.T) {
    t.Run("Create", func(t *testing.T) {
        t.Run("WithValidData", func(t *testing.T) {
            // test
        })
        t.Run("WithInvalidData", func(t *testing.T) {
            // test
        })
    })

    t.Run("Update", func(t *testing.T) {
        // test
    })
}
```

Neotest правильно парсит структуру через Treesitter.

### 4. Benchmarks

```go
func BenchmarkAdd(b *testing.B) {
    for i := 0; i < b.N; i++ {
        Add(2, 3)
    }
}
```

Курсор на `BenchmarkAdd` → `<leader>tt`

## Отладка тестов

### Отладка с nvim-dap

1. Откройте тест файл
2. Поставьте breakpoint: `<leader>b`
3. Курсор на тест
4. Запустите отладку: `<leader>td`
5. Тест остановится на breakpoint

Используйте все команды DAP:
- `<F1>` - continue
- `<leader>sv` - step over
- `<leader>si` - step into
- `<leader>?` - посмотреть значение переменной

### Отладка table tests

```go
func TestAdd(t *testing.T) {
    tests := []struct {
        a, b, want int
    }{
        {2, 3, 5},
        {-1, -1, -2},
    }

    for _, tt := range tests {
        result := Add(tt.a, tt.b)  // <- breakpoint здесь
        if result != tt.want {
            t.Errorf("...")
        }
    }
}
```

Breakpoint сработает на каждой итерации.

## Test Coverage (покрытие кода)

### Автоматический coverage

Neotest настроен генерировать `coverage.out` при запуске тестов.

После `<leader>tt`:
1. Тест выполнится
2. Создастся `coverage.out`
3. nvim-coverage автоматически загрузит его
4. В коде появятся цветные полоски:
   - **Зеленая** (`▎`) - строка покрыта тестами
   - **Красная** (`▎`) - строка НЕ покрыта
   - **Желтая** (`▎`) - частично покрыта

### Ручная загрузка coverage

```vim
" Загрузить coverage.out
<leader>cl

" Показать статистику
<leader>cs
```

### Coverage summary

```vim
<leader>cs
```

Покажет:
```
Coverage Summary:
  File: user.go
    Total Lines: 150
    Covered: 120
    Coverage: 80.0%

  File: order.go
    Total Lines: 200
    Covered: 180
    Coverage: 90.0%
```

### Workflow для TDD

1. Напишите тест (будет красным ✗)
2. Напишите код
3. `<leader>tt` - запустите тест
4. Тест станет зеленым ✓
5. `<leader>cc` - посмотрите coverage
6. Красные строки = нужны еще тесты

## Продвинутые возможности

### Watch mode (автозапуск)

```vim
<leader>tw
```

Теперь при каждом сохранении файла (`:w`) тесты запустятся автоматически!

Удобно для TDD:
1. `<leader>tw` - включить watch
2. Пишете код
3. `:w` - тесты запускаются сами
4. Видите результат сразу

### Build tags

Neotest-golang поддерживает build tags:

```go
//go:build integration
// +build integration

func TestDatabaseIntegration(t *testing.T) {
    // ...
}
```

Для запуска с тегами отредактируйте `lua/plugins/neotest.lua`:

```lua
go_test_args = {
    "-v",
    "-race",
    "-count=1",
    "-tags=integration",  -- Добавить build tag
},
```

### Переменные окружения для тестов

В `lua/plugins/neotest.lua`:

```lua
require("neotest-golang")({
    go_test_args = { "-v", "-race" },
    env = {
        DATABASE_URL = "postgres://localhost/test_db",
        REDIS_URL = "redis://localhost:6379",
    },
})
```

### Тестирование с таймаутом

По умолчанию timeout 60s. Для долгих интеграционных тестов:

```lua
go_test_args = {
    "-v",
    "-timeout=300s",  -- 5 минут
},
```

## Интеграция с CI/CD

### Локальный запуск как в CI

```vim
" Запустить все тесты с race detector и coverage
<leader>ta
```

Это эквивалентно:
```bash
go test -v -race -count=1 -coverprofile=coverage.out ./...
```

### Проверка перед push

1. `<leader>ta` - все тесты
2. `<leader>cs` - проверить что coverage > 80%
3. Если все зеленое → можно делать git push

## Примеры тестирования микросервисов

### HTTP handlers

```go
func TestCreateUserHandler(t *testing.T) {
    // Setup
    router := setupRouter()
    w := httptest.NewRecorder()

    body := `{"name":"John","email":"john@example.com"}`
    req, _ := http.NewRequest("POST", "/users", strings.NewReader(body))
    req.Header.Set("Content-Type", "application/json")

    // Execute
    router.ServeHTTP(w, req)

    // Assert
    assert.Equal(t, 201, w.Code)
}
```

Курсор на `TestCreateUserHandler` → `<leader>td` для отладки.

### Repository тесты с БД

```go
func TestUserRepository_Create(t *testing.T) {
    // Setup test database
    db := setupTestDB(t)
    defer db.Close()

    repo := NewUserRepository(db)

    // Test
    user := &User{Name: "John", Email: "john@example.com"}
    err := repo.Create(user)

    // Assert
    assert.NoError(t, err)
    assert.NotZero(t, user.ID)
}
```

Настройте тестовую БД в переменных окружения (см. выше).

### Тесты с моками

```go
func TestUserService_GetUser(t *testing.T) {
    // Mock repository
    mockRepo := new(MockUserRepository)
    mockRepo.On("FindByID", 1).Return(&User{ID: 1, Name: "John"}, nil)

    // Test service
    service := NewUserService(mockRepo)
    user, err := service.GetUser(1)

    // Assert
    assert.NoError(t, err)
    assert.Equal(t, "John", user.Name)
    mockRepo.AssertExpectations(t)
}
```

## Troubleshooting

### Тесты не запускаются

1. Проверьте что Go установлен: `go version`
2. Проверьте что вы в Go проекте: `go.mod` должен быть
3. Перезапустите Neovim

### "No tests found"

1. Убедитесь что файл заканчивается на `_test.go`
2. Функция теста должна начинаться с `Test`
3. Курсор должен быть на функции теста или внутри нее

### Coverage не загружается

1. Проверьте что `coverage.out` существует: `:!ls coverage.out`
2. Загрузите вручную: `<leader>cl`
3. Проверьте что тесты запускались с `-coverprofile`

### Тесты медленные

Запускайте только нужный тест вместо всех:
- `<leader>tt` вместо `<leader>ta`
- Отключите `-race` если не нужен (в neotest.lua)

### Neotest UI не показывается

```vim
:checkhealth neotest
```

Проверит все зависимости.

## Полезные команды

### Go команды из Neovim

У вас уже установлен go.nvim, команды:

```vim
:GoTest             - запустить тесты (go.nvim способ)
:GoTestFunc         - тест под курсором
:GoTestFile         - все тесты в файле
:GoCoverage         - показать coverage (go.nvim)
:GoAlt              - переключиться между code ↔ test файлом
```

Neotest и go.nvim дополняют друг друга:
- **go.nvim** - быстрые команды, интеграция с go инструментами
- **neotest** - UI, отладка, watch mode, visual feedback

### Генерация тестов

```vim
:GoTestAdd  " Сгенерировать тест для функции под курсором
```

Или используйте `gotests`:
```bash
gotests -all -w file.go
```

## Интеграция с vim-dadbod (БД тесты)

Для интеграционных тестов с БД:

1. Настройте тестовую БД в dadbod
2. Перед запуском тестов подготовьте данные:
   - `<leader>db` - откройте UI
   - Выполните seed SQL
3. Запустите тесты: `<leader>tt`
4. После тестов очистите БД

## Быстрая шпаргалка

```
ЗАПУСК:
<leader>tt       - тест под курсором
<leader>tf       - все тесты в файле
<leader>ta       - весь test suite
<leader>tl       - повторить последний

ОТЛАДКА:
<leader>td       - отладить тест
<leader>b        - breakpoint (в коде теста)

РЕЗУЛЬТАТЫ:
<leader>to       - показать output
<leader>tS       - дерево тестов
]t / [t          - следующий/предыдущий failed

COVERAGE:
<leader>cc       - toggle coverage
<leader>cs       - статистика
Зеленая полоска  - покрыто
Красная полоска  - не покрыто

WATCH MODE:
<leader>tw       - автозапуск при :w

GO.NVIM:
:GoAlt           - переключиться code ↔ test
:GoTestAdd       - сгенерировать тест
```

## Рекомендуемый workflow

### Разработка новой фичи

1. `:GoAlt` - создать `_test.go` файл
2. Написать тест (TDD)
3. `<leader>tw` - включить watch mode
4. Писать код, сохранять → тесты запускаются сами
5. Когда все зеленое: `<leader>cc` - проверить coverage
6. Если coverage низкий - добавить тесты
7. `<leader>tw` - выключить watch
8. Готово к коммиту!

### Отладка failed теста

1. `<leader>ta` - запустить все тесты
2. `]t` - перейти к failed тесту
3. `<leader>b` - поставить breakpoint
4. `<leader>td` - запустить с отладчиком
5. `<leader>sv` / `<leader>si` - шагать по коду
6. Найти баг, исправить
7. `<leader>tt` - проверить что починили

### Code review перед PR

1. `<leader>ta` - все тесты должны быть зелеными
2. `<leader>cs` - coverage summary
3. Проверить что минимум 80% coverage
4. Открыть каждый файл → `<leader>cc`
5. Красные линии = нужны тесты
6. Добавить недостающие тесты
7. Повторить пока все зеленое

---

**Совет**: Привыкайте запускать `<leader>tt` после каждого изменения кода. Чем раньше найдете баг - тем проще исправить!
