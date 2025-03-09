# Docker XAMPP 开发环境

## 1. 简介

本项目为 HKU ICOM6034 Web Engineering 课程提供了一个简便易用的开发环境。该课程主要使用 HTML、CSS、JavaScript 和 PHP 进行教学，同时深入涵盖 jQuery、AJAX、Laravel 和 Vite 等现代 Web 技术栈。

借助 Docker 技术，你可以在几分钟内快速搭建完整的模拟 XAMPP 环境，无需担心复杂的安装和配置过程。尽管可以在传统 XAMPP 环境中进行课程实践，但本项目通过 Docker 和 Docker Compose 提供了一个更一致、可移植且易于配置的替代方案。

该环境专为课程实验（Lab）和个人项目开发而设计，确保所有学生使用相同的开发环境，避免因环境差异而产生的问题。无论是完成每周的实验任务，还是开发学期项目，本环境都提供必要的工具和配置支持，让你能够专注于代码实现，而无需担心环境配置。

### 技术栈详情

- **PHP 8.2**：最新的稳定版 PHP，带有常用扩展（pdo_mysql, mysqli, gd, mbstring 等）
- **Apache 2.4**：支持.htaccess 和 URL 重写，配置为支持 Laravel 项目
- **MariaDB 10.6**：MySQL 的高性能分支，完全兼容 Laravel
- **phpMyAdmin**：数据库管理工具，方便可视化操作数据库
- **Node.js 22.x**：支持前端资源编译
- **Composer**：PHP 依赖管理工具
- **Docker**：确保环境一致性和隔离性

### 项目结构

```bash
xampp-docker/
├── config/                      # 配置文件目录
│   ├── apache2/                 # Apache配置
│   │   └── sites-available/     # 虚拟主机配置文件
│   ├── mariadb/                 # MariaDB配置
│   │   └── init/                # 数据库初始化脚本
│   └── php/                     # PHP配置
│       └── custom.ini           # PHP自定义配置
├── data/                        # 数据持久化存储
│   └── mariadb/                 # MariaDB数据文件
├── www/                         # Web根目录
│   └── lv-bookstore/            # 项目目录
├── .env                         # 环境变量配置
├── .env.example                 # 环境变量示例
├── scripts/                     # 脚本目录
│   ├── xampp.sh                 # 环境管理脚本
│   └── project-manager.sh       # 项目管理脚本
├── docker-compose.yml           # Docker服务配置
└── Dockerfile                   # Apache-PHP镜像构建文件
```

## 2. 快速开始

在开始前，请确保你的计算机上已安装：

- [Docker Desktop](https://www.docker.com/products/docker-desktop/)（27.5.0 或更高版本）
- 支持 Bash 脚本的终端（Windows 用户可使用 Git Bash 或 WSL）

### 步骤 1：获取项目

```bash
git clone https://github.com/BaizeXS/xampp-docker.git
cd xampp-docker
```

### 步骤 2：根据你的系统调整配置

**重要：** 根据你的机器架构可能需要调整以下配置：

- **ARM 架构**（Mac M1/M2/M3/M4）：默认配置已适配 ARM 架构

- **x86 架构**（大多数 Windows 和 Intel Mac）：需修改`docker-compose.yml`中的 phpMyAdmin 镜像：

  ```yaml
  # 将此行
  image: arm64v8/phpmyadmin
  # 改为
  image: phpmyadmin/phpmyadmin
  ```

### 步骤 3：给脚本添加执行权限

```bash
chmod +x scripts/xampp.sh scripts/project-manager.sh
```

### 步骤 4：启动环境

```bash
./scripts/xampp.sh start
```

### 步骤 5：访问服务

- **网站首页**：http://localhost
- **数据库管理**：http://localhost:8080
  - 用户名：root
  - 密码：root（可在.env 中修改）

## 3. 命令说明

### 环境管理

```bash
./scripts/xampp.sh [命令]
```

**可用命令**:

- `start` - 启动 Docker 环境
- `stop` - 停止 Docker 环境
- `restart` - 重启 Docker 环境
- `status` - 显示 Docker 环境状态
- `shell` - 进入 Apache 容器的 shell
- `mysql` - 进入 MariaDB 客户端
- `logs` - 查看 Apache 容器日志
- `info` - 显示环境信息（各组件版本、访问地址）

**使用示例**:

```bash
# 启动环境
./scripts/xampp.sh start

# 查看环境信息
./scripts/xampp.sh info

# 进入容器shell
./scripts/xampp.sh shell
```

### 项目管理

```bash
./scripts/project-manager.sh [命令] [子命令] [参数...]
```

#### 创建新的 Laravel 项目

```bash
./scripts/project-manager.sh create [项目名] [选项]
```

**选项**:

- `--vue` - 添加 Vue 支持并配置 Vite
- `--db-name=DBNAME` - 指定数据库名(默认与项目名相同)

**示例**:

```bash
# 创建基本Laravel项目
./scripts/project-manager.sh create blog

# 创建带Vue支持的Laravel项目
./scripts/project-manager.sh create blog --vue
```

#### 初始化已有项目

```bash
./scripts/project-manager.sh init [项目名] [选项]
```

**选项**:

- `--db-name=DBNAME` - 指定数据库名(默认与项目名相同)
- `--db-init` - 初始化数据库(运行迁移)
- `--npm-install` - 安装前端依赖

**示例**:

```bash
# 初始化已有项目
./scripts/project-manager.sh init blog

# 初始化并设置数据库
./scripts/project-manager.sh init blog --db-name=custom_db --db-init

# 完整初始化(包括前端依赖)
./scripts/project-manager.sh init blog --db-init --npm-install
```

#### 管理 Apache 虚拟主机配置

```bash
./scripts/project-manager.sh config [子命令] [参数...]
```

**子命令**:

- `list` - 列出所有可用 Apache 虚拟主机配置
- `active` - 显示当前活动的 Apache 虚拟主机配置
- `enable [项目名]` - 启用指定的 Apache 虚拟主机配置
- `disable [项目名]` - 禁用指定的 Apache 虚拟主机配置
- `switch [项目名]` - 切换到指定的 Apache 虚拟主机配置
- `basic` - 切换到默认 Apache 虚拟主机配置
- `create [项目名]` - 根据模版创建新的 Apache 虚拟主机配置

**示例**:

```bash
# 列出所有项目
./scripts/project-manager.sh config list

# 切换到指定项目
./scripts/project-manager.sh config switch mysite
```

#### 管理开发环境

```bash
./scripts/project-manager.sh dev [子命令] [项目名]
```

**子命令**:

- `start [项目名]` - 启动项目的开发环境
- `stop [项目名]` - 停止项目的开发环境
- `status` - 显示所有正在运行的开发环境
- `fix-vite [项目名]` - 修复项目的 Vite 配置

启动开发环境将同时启动：

- PHP Artisan Serve (访问：http://localhost:8000)
- npm 开发服务器 (访问：http://localhost:5173)

**示例**:

```bash
# 启动指定项目的开发环境
./scripts/project-manager.sh dev start myblog
```

## 4. 配置说明

### 环境变量

环境配置在`.env`文件中，包含以下主要设置：

```bash
# MariaDB设置
MARIADB_ROOT_PASSWORD=root      # 数据库root密码
MARIADB_DATABASE=laravel        # 默认创建的数据库
MARIADB_USER=user               # 额外的数据库用户
MARIADB_PASSWORD=password       # 数据库用户密码
DB_PORT=3306                    # 数据库端口映射

# Web服务器设置
WEB_PORT=80                     # Web服务器端口
SSL_PORT=443                    # SSL端口
VITE_PORT=5173                  # Vite开发服务器端口
LARAVEL_PORT=8000               # Laravel开发服务器端口

# phpMyAdmin设置
PMA_PORT=8080                   # phpMyAdmin访问端口
```

如果修改了这些设置，需要重启环境：`./scripts/xampp.sh restart`

### 数据库初始化

如果需要在数据库首次创建时自动执行 SQL 脚本，可以将`.sql`文件放入`config/mariadb/init/`目录。

## 5. 项目开发指南

### 完整工作流程示例

#### 初始设置

```bash
# 启动环境
./scripts/xampp.sh start

# 查看环境信息
./scripts/xampp.sh info
```

#### 创建新项目

```bash
# 创建带Vue支持的Laravel项目
./scripts/project-manager.sh create myblog --vue
```

#### 激活项目配置

```bash
# 切换到新项目
./scripts/project-manager.sh config switch myblog
```

#### 开发工作流

```bash
# 查看Apache日志
./scripts/xampp.sh logs

# 进入容器shell执行命令
./scripts/xampp.sh shell

# 在容器中构建前端资源
cd /var/www/html/myblog && npm run build

# 启动开发服务器
./scripts/project-manager.sh dev start myblog
```

### 常用 Laravel 命令

在 shell 内执行：

```bash
# 数据库迁移
php artisan migrate

# 创建控制器
php artisan make:controller BookController

# 创建模型
php artisan make:model Book -m

# 运行数据库种子
php artisan db:seed

# 清除缓存
php artisan cache:clear
```

## 6. 端口使用说明

本环境使用以下端口：

- 80: Apache HTTP
- 443: Apache HTTPS
- 8080: phpMyAdmin
- 3306: MariaDB
- 5173: Vite 开发服务器
- 8000: PHP Artisan 服务器

## 7. 常见问题与解决方案

### 1. 无法访问项目

**解决方案**：

- 确认环境是否正在运行：`./scripts/xampp.sh status`

- 检查 Apache 配置：

  ```bash
  ./scripts/xampp.sh shell
  cat /etc/apache2/sites-enabled/000-default.conf
  service apache2 reload
  ```

- 尝试重启环境：`./scripts/xampp.sh restart`

### 2. 数据库连接错误

**解决方案**：

- 检查项目的`.env`文件配置：

  ```
  DB_CONNECTION=mysql
  DB_HOST=mariadb
  DB_PORT=3306
  DB_DATABASE=laravel
  DB_USERNAME=root
  DB_PASSWORD=root
  ```

- 确认 MariaDB 容器是否正在运行：`./scripts/xampp.sh status`

### 3. 权限问题

**解决方案**：

```bash
./scripts/xampp.sh shell
chmod -R 775 /var/www/html/你的项目/storage
chmod -R 775 /var/www/html/你的项目/bootstrap/cache
```

### 4. 代码更改未生效

**解决方案**：

- 清除 Laravel 缓存：

  ```bash
  cd /var/www/html/你的项目
  php artisan cache:clear
  php artisan config:clear
  php artisan view:clear
  ```

- 强制刷新浏览器（Ctrl+F5 或 Cmd+Shift+R）

### 5. 端口冲突

**解决方案**：

- 修改`.env`文件中的端口设置，然后重启环境：`./scripts/xampp.sh restart`
