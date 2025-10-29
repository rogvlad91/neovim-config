# Работа с базами данных в Neovim

## Установленные плагины

- **vim-dadbod** - Основной плагин для работы с БД
- **vim-dadbod-ui** - UI для навигации и управления
- **vim-dadbod-completion** - Автодополнение таблиц и колонок

## Поддерживаемые базы данных

- PostgreSQL
- MySQL/MariaDB
- MongoDB
- Redis
- SQLite
- SQL Server
- ClickHouse
- DuckDB
- BigQuery
- Snowflake

## Горячие клавиши

| Клавиша | Действие | Описание |
|---------|----------|----------|
| `<leader>db` | Toggle UI | Открыть/закрыть панель БД |
| `<leader>dba` | Add Connection | Добавить новое подключение |
| `<leader>dbf` | Find Buffer | Найти SQL буфер |
| `<Leader>W` | Save Query | Сохранить запрос (в SQL файле) |

## Настройка подключений

### Способ 1: В конфигурации (lua/plugins/dadbod.lua)

Раскомментируйте и настройте блок:

```lua
vim.g.dbs = {
    dev = "postgres://user:password@localhost:5432/mydb",
    staging = "postgres://user:password@staging:5432/mydb",
    production = "postgres://user:password@prod:5432/mydb",
}
```

### Способ 2: Через переменные окружения

```bash
# В ~/.zshrc или ~/.bashrc
export DATABASE_URL="postgres://user:password@localhost:5432/mydb"
```

Dadbod автоматически подхватит `$DATABASE_URL`.

### Способ 3: Через UI

1. Откройте UI: `<leader>db`
2. Нажмите `A` (Add Connection)
3. Введите URL подключения

### Форматы URL подключений

**PostgreSQL:**
```
postgres://user:password@localhost:5432/database_name
postgresql://user:password@localhost:5432/database_name?sslmode=disable
```

**MySQL:**
```
mysql://user:password@localhost:3306/database_name
```

**MongoDB:**
```
mongodb://user:password@localhost:27017/database_name
```

**SQLite:**
```
sqlite:path/to/database.db
sqlite:/absolute/path/to/database.db
```

**Redis:**
```
redis://localhost:6379/0
```

### Docker подключения

Если БД в Docker:

```lua
vim.g.dbs = {
    docker_postgres = "postgres://postgres:password@localhost:5432/mydb",
    docker_mongo = "mongodb://admin:password@localhost:27017/mydb",
}
```

Убедитесь что порты exposed в docker-compose.yml:
```yaml
services:
  postgres:
    image: postgres:15
    ports:
      - "5432:5432"  # Host:Container
```

## Использование UI

### Открытие UI

```vim
:DBUI
" или
<leader>db
```

### Навигация в UI

| Клавиша | Действие |
|---------|----------|
| `<CR>` | Раскрыть/открыть элемент |
| `o` | Открыть в новом окне |
| `S` | Открыть в вертикальном split |
| `d` | Удалить буфер |
| `R` | Обновить UI |
| `A` | Добавить подключение |
| `H` | Переключить помощь |

### Структура UI

```
▾ database_name (подключение)
  ▾ schemas (только для Postgres)
    ▾ public
      ▾ tables
        ▸ users
        ▸ posts
      ▸ views
  ▾ saved_queries (сохраненные запросы)
  ▸ buffers (открытые буферы)
```

### Работа с таблицами

1. Раскройте подключение
2. Раскройте `tables`
3. Нажмите `<CR>` на таблице → откроется список колонок
4. Нажмите `<CR>` снова → выполнится `SELECT * FROM table LIMIT 200`

## Выполнение запросов

### Способ 1: Из UI

1. Откройте `buffers` → `new query`
2. Напишите SQL запрос
3. Выделите запрос в Visual mode
4. Нажмите `<Leader>` (обычно Space)
5. Выберите подключение

### Способ 2: Напрямую из .sql файла

```vim
" Создайте файл
:e query.sql

" Напишите запрос
SELECT * FROM users WHERE age > 18;

" Visual mode: выделите запрос
" Нажмите <CR> или используйте команду
:DB g:dbs.dev
```

### Способ 3: Команда :DB

```vim
:DB postgres://localhost/mydb SELECT * FROM users;
```

### Автодополнение

В SQL файлах автоматически работает:
- Дополнение имен таблиц
- Дополнение колонок
- Понимание алиасов

```sql
SELECT u.| FROM users u
       ^
       | Здесь нажмите Ctrl+Space - увидите колонки таблицы users
```

## Сохранение запросов

### Временные запросы

По умолчанию все запросы сохраняются в tmp папку.

### Постоянное сохранение

В SQL буфере:
1. Напишите запрос
2. Нажмите `<Leader>W` (обычно `<Space>W`)
3. Запрос сохранится в `~/.local/share/nvim/db_ui/`

Структура сохраненных запросов:
```
~/.local/share/nvim/db_ui/
  └── connections/
      └── database_name/
          └── saved_queries/
              └── my_query.sql
```

### Доступ к сохраненным запросам

В UI раскройте:
```
▾ database_name
  ▾ saved_queries
    ▸ my_query.sql
```

Нажмите `<CR>` для выполнения.

## Примеры работы

### PostgreSQL: Создание таблицы

```sql
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

### PostgreSQL: Запросы с JOIN

```sql
SELECT
    u.name,
    COUNT(p.id) as post_count
FROM users u
LEFT JOIN posts p ON u.id = p.user_id
GROUP BY u.id, u.name
HAVING COUNT(p.id) > 5
ORDER BY post_count DESC;
```

### MongoDB: Запросы

```javascript
db.users.find({ age: { $gt: 18 } })
db.users.aggregate([
  { $match: { status: "active" } },
  { $group: { _id: "$country", count: { $sum: 1 } } }
])
```

### Redis: Команды

```redis
GET mykey
SET mykey "value"
KEYS user:*
HGETALL user:123
```

## Workflow для микросервисов

### 1. Настройка подключений для всех сервисов

```lua
vim.g.dbs = {
    -- Сервис Auth
    auth_dev = "postgres://postgres:pass@localhost:5432/auth_db",

    -- Сервис Users
    users_dev = "postgres://postgres:pass@localhost:5433/users_db",

    -- Сервис Orders
    orders_dev = "postgres://postgres:pass@localhost:5434/orders_db",

    -- Redis для кеша
    redis_cache = "redis://localhost:6379/0",

    -- MongoDB для логов
    mongo_logs = "mongodb://admin:pass@localhost:27017/logs",
}
```

### 2. Docker Compose подключения

Если все БД в Docker Compose:

```yaml
# docker-compose.yml
services:
  postgres-auth:
    image: postgres:15
    ports:
      - "5432:5432"
    environment:
      POSTGRES_DB: auth_db
      POSTGRES_PASSWORD: password

  postgres-users:
    image: postgres:15
    ports:
      - "5433:5432"  # Другой внешний порт!
    environment:
      POSTGRES_DB: users_db
```

Подключение в Neovim:
```lua
auth_db = "postgres://postgres:password@localhost:5432/auth_db",
users_db = "postgres://postgres:password@localhost:5433/users_db",
```

### 3. Проверка данных между сервисами

Создайте сохраненный запрос для частых проверок:

```sql
-- Проверить связь user_id между Auth и Users
-- В auth_db
SELECT id, email FROM users WHERE id = 123;

-- В users_db
SELECT * FROM user_profiles WHERE user_id = 123;
```

### 4. Отладка проблем в production

Безопасное подключение через SSH tunnel:

```bash
# Создайте SSH туннель
ssh -L 5432:localhost:5432 user@production-server

# Теперь production БД доступна через localhost:5432
```

В Neovim:
```lua
vim.g.dbs = {
    prod = "postgres://readonly_user:pass@localhost:5432/prod_db",
}
```

**⚠️ ВАЖНО**: Используйте только readonly пользователя для production!

## Полезные SQL сниппеты для Go разработки

### Проверка миграций

```sql
SELECT version, dirty FROM schema_migrations ORDER BY version DESC;
```

### Анализ slow queries

```sql
-- PostgreSQL
SELECT
    query,
    calls,
    total_time,
    mean_time
FROM pg_stat_statements
ORDER BY mean_time DESC
LIMIT 10;
```

### Проверка locks

```sql
-- PostgreSQL
SELECT
    pid,
    usename,
    pg_blocking_pids(pid) as blocked_by,
    query
FROM pg_stat_activity
WHERE cardinality(pg_blocking_pids(pid)) > 0;
```

### Размер таблиц

```sql
-- PostgreSQL
SELECT
    schemaname,
    tablename,
    pg_size_pretty(pg_total_relation_size(schemaname||'.'||tablename)) AS size
FROM pg_tables
WHERE schemaname = 'public'
ORDER BY pg_total_relation_size(schemaname||'.'||tablename) DESC;
```

## Troubleshooting

### Ошибка: "Could not connect to database"

1. Проверьте что БД запущена:
   ```bash
   docker ps  # для Docker
   pg_isready  # для PostgreSQL
   ```

2. Проверьте URL подключения
3. Проверьте firewall/порты

### Ошибка: "psql: command not found" (или mysql, mongo и т.д.)

Установите CLI клиент для вашей БД:

```bash
# PostgreSQL
brew install libpq
brew link --force libpq

# MySQL
brew install mysql-client

# MongoDB
brew install mongosh
```

### Автодополнение не работает

1. Убедитесь что vim-dadbod-completion установлен
2. Проверьте что вы в SQL файле (`:set ft=sql`)
3. Переоткройте файл

### UI не показывает таблицы

1. Нажмите `R` для обновления
2. Проверьте подключение
3. Перезапустите Neovim

## Безопасность

### Не храните пароли в конфиге!

❌ **Плохо:**
```lua
vim.g.dbs = {
    prod = "postgres://admin:MyP@ssw0rd@prod.example.com/db"
}
```

✅ **Хорошо:**
```lua
-- Используйте переменные окружения
vim.g.dbs = {
    prod = os.getenv("PROD_DATABASE_URL")
}
```

Или создайте файл `~/.config/nvim/db_credentials.lua` (добавьте в .gitignore!):
```lua
-- db_credentials.lua (НЕ коммитить!)
return {
    prod = "postgres://user:pass@host/db"
}
```

В основном конфиге:
```lua
local credentials = require("db_credentials")
vim.g.dbs = credentials
```

### Read-only пользователи для production

Создайте пользователя только с правами SELECT:

```sql
-- PostgreSQL
CREATE USER readonly WITH PASSWORD 'secure_password';
GRANT CONNECT ON DATABASE mydb TO readonly;
GRANT USAGE ON SCHEMA public TO readonly;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO readonly;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT ON TABLES TO readonly;
```

## Быстрая шпаргалка

```
ОТКРЫТИЕ:
<leader>db       - открыть UI
:DBUI            - открыть UI

НАВИГАЦИЯ В UI:
<CR>             - раскрыть/выполнить
S                - открыть в split
R                - обновить
A                - добавить подключение

ЗАПРОСЫ:
Visual + <CR>    - выполнить выделенное
<Leader>W        - сохранить запрос
:DB <url> <sql>  - выполнить напрямую

АВТОДОПОЛНЕНИЕ:
Ctrl+Space       - показать дополнение
Работает автоматически в .sql файлах
```

## Интеграция с Go проектами

### Генерация моделей из БД

Используйте sqlc или sqlboiler:

```bash
# sqlc
sqlc generate

# Затем откройте сгенерированные модели в Neovim
nvim internal/db/models.go
```

### Проверка запросов перед деплоем

1. Откройте `.sql` файл с миграцией
2. Выполните на dev БД через vim-dadbod
3. Проверьте результат
4. Закоммитьте

---

**Совет**: Создайте алиас в shell для быстрого открытия Neovim с БД UI:
```bash
alias nvdb="nvim -c 'DBUI'"
```
