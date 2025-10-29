# Отладка Go проектов в Neovim

## Установленные плагины

- **nvim-dap** - Debug Adapter Protocol для Neovim
- **nvim-dap-ui** - UI для отладчика
- **nvim-dap-go** - специфичная интеграция для Go
- **nvim-dap-virtual-text** - показывает значения переменных прямо в коде

## Требования

### Установка Delve (Go debugger)

```bash
# Установка delve
go install github.com/go-delve/delve/cmd/dlv@latest

# Проверка установки
dlv version
```

## Горячие клавиши для отладки

### Управление отладчиком

| Клавиша | Действие | Описание |
|---------|----------|----------|
| `<F1>` | Continue | Продолжить выполнение до следующего breakpoint |
| `<leader>b` | Toggle Breakpoint | Поставить/убрать точку останова |
| `<leader>dt` | Toggle UI | Показать/скрыть интерфейс отладчика |
| `<leader>db` | Run to Cursor | Выполнить до позиции курсора |

### Навигация по коду (Step)

| Клавиша | Действие | Описание |
|---------|----------|----------|
| `<leader>si` | Step Into | Войти внутрь функции |
| `<leader>sv` | Step Over | Перешагнуть через функцию |
| `<leader>so` | Step Out | Выйти из текущей функции |
| `<leader>sb` | Step Back | Шаг назад (если поддерживается) |
| `<leader>sr` | Restart | Перезапустить отладку |

### Просмотр переменных

| Клавиша | Действие | Описание |
|---------|----------|----------|
| `<leader>?` | Eval | Вычислить выражение под курсором |

## Отладка микросервисов в Docker Compose

### Способ 1: Remote Debugging через Delve (рекомендуется)

#### Шаг 1: Настройка Dockerfile для отладки

Создайте `Dockerfile.debug`:

```dockerfile
FROM golang:1.21-alpine

WORKDIR /app

# Установить delve
RUN go install github.com/go-delve/delve/cmd/dlv@latest

COPY go.mod go.sum ./
RUN go mod download

COPY . .

# Собрать с флагами отладки
RUN go build -gcflags="all=-N -l" -o /app/service ./cmd/service

# Expose порт для delve
EXPOSE 2345

# Запустить delve в headless режиме
CMD ["/go/bin/dlv", "exec", "/app/service", "--headless", "--listen=:2345", "--api-version=2", "--accept-multiclient"]
```

#### Шаг 2: Обновить docker-compose.yml

```yaml
version: '3.8'

services:
  # Другие сервисы (database, redis и т.д.)
  postgres:
    image: postgres:15
    ports:
      - "5432:5432"
    environment:
      POSTGRES_PASSWORD: password

  # Ваш микросервис в режиме отладки
  my-service:
    build:
      context: ./services/my-service
      dockerfile: Dockerfile.debug  # Используем debug версию
    ports:
      - "8080:8080"    # Порт приложения
      - "2345:2345"    # Порт delve для отладки
    environment:
      DATABASE_URL: postgres://postgres:password@postgres:5432/mydb
      DEBUG: "true"
    depends_on:
      - postgres
    security_opt:
      - "apparmor=unconfined"  # Требуется для отладчика
    cap_add:
      - SYS_PTRACE             # Требуется для delve
```

#### Шаг 3: Запустить Docker Compose

```bash
# Запустить все сервисы
docker-compose up -d

# Или только нужный сервис
docker-compose up -d my-service postgres
```

#### Шаг 4: Настроить Neovim для подключения

В вашей конфигурации уже настроен базовый DAP. Добавьте remote конфигурацию:

```vim
:lua require('dap').configurations.go = vim.list_extend(require('dap').configurations.go or {}, {
  {
    type = "go",
    name = "Attach to Docker",
    request = "attach",
    mode = "remote",
    remotePath = "/app",
    port = 2345,
    host = "127.0.0.1",
    substitutePath = {
      { from = "${workspaceFolder}", to = "/app" }
    }
  }
})
```

Или создайте файл `.vscode/launch.json` (DAP может его читать):

```json
{
  "version": "0.2.0",
  "configurations": [
    {
      "name": "Attach to Docker",
      "type": "go",
      "request": "attach",
      "mode": "remote",
      "remotePath": "/app",
      "port": 2345,
      "host": "127.0.0.1"
    }
  ]
}
```

#### Шаг 5: Начать отладку

1. Откройте файл Go в Neovim
2. Поставьте breakpoint: `<leader>b`
3. Запустите отладку:
   ```vim
   :DapContinue
   ```
4. Выберите конфигурацию "Attach to Docker"
5. Сделайте HTTP запрос к вашему сервису (curl, Postman и т.д.)
6. Отладчик остановится на breakpoint

### Способ 2: Выборочная отладка (один сервис локально)

Если хотите отлаживать только один микросервис локально, а остальные в Docker:

#### Шаг 1: Обновить docker-compose.yml

```yaml
services:
  postgres:
    image: postgres:15
    ports:
      - "5432:5432"  # Expose наружу

  redis:
    image: redis:7
    ports:
      - "6379:6379"  # Expose наружу

  other-service:
    build: ./services/other-service
    ports:
      - "8081:8081"

  # my-service закомментирован - запустим локально
  # my-service:
  #   build: ./services/my-service
  #   ports:
  #     - "8080:8080"
```

#### Шаг 2: Запустить зависимости

```bash
docker-compose up -d postgres redis other-service
```

#### Шаг 3: Запустить сервис локально в Neovim

Создайте `.env` файл с переменными окружения:
```env
DATABASE_URL=postgres://postgres:password@localhost:5432/mydb
REDIS_URL=redis://localhost:6379
OTHER_SERVICE_URL=http://localhost:8081
```

В Neovim:
1. Поставьте breakpoints
2. Запустите отладку: `<F1>`
3. DAP запустит ваш сервис локально с доступом к Docker зависимостям

### Способ 3: Docker Compose с несколькими debug портами

Если нужно отлаживать несколько сервисов одновременно:

```yaml
services:
  service-a:
    build:
      context: ./service-a
      dockerfile: Dockerfile.debug
    ports:
      - "8080:8080"
      - "2345:2345"  # Debug port для service-a
    cap_add:
      - SYS_PTRACE

  service-b:
    build:
      context: ./service-b
      dockerfile: Dockerfile.debug
    ports:
      - "8081:8081"
      - "2346:2345"  # Debug port для service-b (внешний 2346, внутри 2345)
    cap_add:
      - SYS_PTRACE
```

Конфигурации в Neovim:

```lua
require('dap').configurations.go = {
  {
    name = "Attach to Service A",
    type = "go",
    request = "attach",
    mode = "remote",
    remotePath = "/app",
    port = 2345,
    host = "127.0.0.1",
  },
  {
    name = "Attach to Service B",
    type = "go",
    request = "attach",
    mode = "remote",
    remotePath = "/app",
    port = 2346,
    host = "127.0.0.1",
  }
}
```

### Способ 4: Использование docker exec для attach

Если сервис уже запущен без delve headless:

```bash
# Найти container ID
docker ps

# Запустить delve внутри контейнера
docker exec -it <container-id> dlv attach $(pgrep service-name) --headless --listen=:2345 --api-version=2
```

Затем подключитесь из Neovim как в Способе 1.

## DAP UI: Окна отладчика

Когда нажимаете `<leader>dt`:

- **Scopes** - локальные и глобальные переменные
- **Stacks** - call stack (стек вызовов функций)
- **Breakpoints** - список всех точек останова
- **REPL/Console** - интерактивная консоль для выполнения команд
- **Watches** - отслеживаемые переменные

## Основные команды DAP

```vim
" Запустить/продолжить отладку
:DapContinue

" Остановить отладку
:DapTerminate

" Установить breakpoint
:DapToggleBreakpoint

" Условный breakpoint
:lua require('dap').set_breakpoint(nil, nil, 'x > 10')

" Logpoint (не останавливает, только логирует)
:lua require('dap').set_breakpoint(nil, nil, nil, 'Value of x: {x}')

" Очистить все breakpoints
:lua require('dap').clear_breakpoints()

" Показать REPL
:lua require('dap').repl.open()

" Переключить конфигурацию
:lua require('dap').continue()
" После этого выберите нужную конфигурацию из списка
```

## Типичные конфигурации для разных случаев

### Debug локального файла

```lua
{
  type = "go",
  name = "Debug current file",
  request = "launch",
  program = "${file}",
}
```

### Debug с переменными окружения

```lua
{
  type = "go",
  name = "Debug with env",
  request = "launch",
  program = "${file}",
  env = {
    DATABASE_URL = "postgres://localhost/mydb",
    DEBUG = "true",
    PORT = "8080",
  },
}
```

### Debug тестов

```lua
{
  type = "go",
  name = "Debug tests",
  request = "launch",
  mode = "test",
  program = "${workspaceFolder}",
}
```

### Attach к запущенному процессу

```lua
{
  type = "go",
  name = "Attach to process",
  request = "attach",
  processId = require('dap.utils').pick_process,
}
```

## Полезные функции для кастомизации

### Автоматическое открытие UI при старте отладки

Добавьте в `lua/plugins/dap.lua`:

```lua
local dap, dapui = require("dap"), require("dapui")

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end

dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end

dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end
```

### Кастомные знаки для breakpoints

```lua
vim.fn.sign_define('DapBreakpoint', {
  text='🔴',
  texthl='DapBreakpoint',
  linehl='DapBreakpoint',
  numhl='DapBreakpoint'
})

vim.fn.sign_define('DapStopped', {
  text='▶️',
  texthl='DapStopped',
  linehl='debugPC',
  numhl='DapStopped'
})
```

## Troubleshooting

### "dlv not found"

```bash
go install github.com/go-delve/delve/cmd/dlv@latest
export PATH=$PATH:$(go env GOPATH)/bin
```

### Отладчик не останавливается на breakpoint

1. Проверьте что код компилируется
2. Breakpoint должен быть на строке с кодом, не на пустой
3. Убедитесь что remotePath и substitutePath правильные для Docker

### "could not attach to pid" в Docker

Добавьте в docker-compose.yml:
```yaml
security_opt:
  - "apparmor=unconfined"
cap_add:
  - SYS_PTRACE
```

### Переменные показывают "optimized out"

Собирайте с флагами:
```bash
go build -gcflags="all=-N -l" .
```

В Dockerfile:
```dockerfile
RUN go build -gcflags="all=-N -l" -o /app/service
```

### Не можем подключиться к remote debugger

```bash
# Проверьте что порт доступен
telnet localhost 2345

# Проверьте что delve запущен в контейнере
docker logs <container-name>

# Проверьте что контейнер слушает на правильном порту
docker exec <container-name> netstat -tlnp | grep 2345
```

## Workflow для микросервисов

### 1. Подготовка

```bash
# Создайте Dockerfile.debug
# Обновите docker-compose.yml с портами отладки
# Запустите сервисы
docker-compose up -d
```

### 2. Проверка что delve запущен

```bash
# Посмотрите логи контейнера
docker logs my-service

# Должно быть что-то типа:
# API server listening at: [::]:2345
```

### 3. Настройка Neovim

```vim
" Откройте код микросервиса
:e services/my-service/main.go

" Поставьте breakpoint
<leader>b
```

### 4. Подключение к отладчику

```vim
:DapContinue
" Выберите "Attach to Docker"
```

### 5. Триггер breakpoint

```bash
# Сделайте запрос к сервису
curl http://localhost:8080/api/endpoint
```

Neovim остановится на breakpoint!

### 6. Навигация и просмотр

- `<leader>?` - посмотреть значение переменной
- `<leader>sv` - step over
- `<leader>si` - step into
- `<F1>` - continue

### 7. Завершение

```vim
:DapTerminate
```

## Быстрая шпаргалка

```
УПРАВЛЕНИЕ:
<F1>             - запустить/продолжить
<leader>dt       - открыть/закрыть UI
<leader>sr       - перезапустить
:DapTerminate    - остановить

BREAKPOINTS:
<leader>b        - toggle breakpoint
<leader>db       - run to cursor

НАВИГАЦИЯ:
<leader>sv       - step over
<leader>si       - step into
<leader>so       - step out
<leader>sr       - restart

ПРОСМОТР:
<leader>?        - eval под курсором
:DapUIToggle     - UI

DOCKER DEBUGGING:
1. Dockerfile.debug с delve headless
2. Expose порт 2345 в docker-compose.yml
3. security_opt + cap_add: SYS_PTRACE
4. :DapContinue → "Attach to Docker"
```

## Продвинутые техники

### Условные breakpoints для HTTP handlers

```lua
-- Остановиться только на POST запросах
require('dap').set_breakpoint(nil, nil, 'r.Method == "POST"')

-- Остановиться только для конкретного user ID
require('dap').set_breakpoint(nil, nil, 'userID == "12345"')
```

### Logpoints для продакшн-like отладки

```lua
-- Не останавливает выполнение, только логирует
require('dap').set_breakpoint(nil, nil, nil, 'Request ID: {requestID}, User: {user.Email}')
```

### Multi-attach для микросервисов

Можете подключиться к нескольким сервисам одновременно, открыв несколько Neovim сессий или используя tmux/screen для разделения терминала.

---

**Ключевая идея для Docker**: Запустите delve в headless режиме внутри контейнера, expose порт 2345, и подключитесь через remote attach из Neovim.
