# 🤖 **HKU ICOM6034 Web Engineering Development Environment**

## 1. Introduction

This project provides a convenient and easy-to-use development environment for the HKU ICOM6034 Web Engineering course. The course primarily uses HTML, CSS, JavaScript, and PHP for teaching, while also covering modern web technology stack including jQuery, AJAX, Laravel, and Vite.

With Docker technology, you can quickly set up a complete simulated XAMPP environment in minutes, without worrying about complex installation and configuration processes. While you can practice the course in a traditional XAMPP environment, this project provides a more consistent, portable, and easily configurable alternative through Docker and Docker Compose.

The environment is designed for course labs and personal project development, ensuring that all students use the same development environment to avoid problems caused by environmental differences. Whether completing weekly lab tasks or developing term projects, this environment provides the necessary tools and configuration support, allowing you to focus on code implementation without worrying about environment configuration.

🚀 **Key Features:**

- Quickly set up a fully simulated XAMPP environment using Docker, avoiding complex installations.
- Provides a consistent, portable, and easily configurable alternative to traditional XAMPP setups.
- Designed for course labs and personal project development, ensuring uniform development environments for all students.
- Facilitates weekly lab tasks and term projects, allowing focus on coding rather than configuration.

### Technology Stack Details

- **PHP 8.2**: The latest stable version of PHP with commonly used extensions (pdo_mysql, mysqli, gd, mbstring, etc.)
- **Apache 2.4**: Supports .htaccess and URL rewriting, configured to support Laravel projects
- **MariaDB 10.6**: High-performance branch of MySQL, fully compatible with Laravel
- **phpMyAdmin**: Database management tool for convenient visual database operations
- **Node.js 22.x**: Supports frontend resource compilation
- **Composer**: PHP dependency management tool
- **Docker**: Ensures environment consistency and isolation

### Project Structure

```bash
xampp-docker/
├── config/                      # Configuration files directory
│   ├── apache2/                 # Apache configuration
│   │   └── sites-available/     # Virtual host configuration files
│   ├── mariadb/                 # MariaDB configuration
│   │   └── init/                # Database initialization scripts
│   └── php/                     # PHP configuration
│       └── custom.ini           # PHP custom configuration
├── data/                        # Data persistence storage
│   └── mariadb/                 # MariaDB data files
├── www/                         # Web root directory
│   └── lv-bookstore/            # Project directory
├── .env                         # Environment variable configuration
├── .env.example                 # Environment variable example
├── scripts/                     # Scripts directory
│   ├── xampp.sh                 # Environment management script
│   └── project-manager.sh       # Project management script
├── docker-compose.yml           # Docker service configuration
└── Dockerfile                   # Apache-PHP image build file
```

## 2. Quick Start

Before starting, make sure you have the following installed on your computer:

- [Docker Desktop](https://www.docker.com/products/docker-desktop/) (version 27.5.0 or higher)
- Terminal supporting Bash scripts (Windows users can use Git Bash or WSL)

### Step 1: Get the Project

```bash
git clone https://github.com/BaizeXS/xampp-docker.git
cd xampp-docker
```

### Step 2: Adjust Configuration According to Your System

**Important:** You may need to adjust the following configuration based on your machine's architecture:

- **ARM Architecture** (Mac M1/M2/M3/M4): Default configuration is already adapted for ARM architecture

- **x86 Architecture** (Most Windows and Intel Mac): Need to modify the phpMyAdmin image in `docker-compose.yml`:

  ```yaml
  # Change this line
  image: arm64v8/phpmyadmin
  # To
  image: phpmyadmin/phpmyadmin
  ```

### Step 3: Add Execution Permission to Scripts

```bash
chmod +x scripts/xampp.sh scripts/project-manager.sh
```

### Step 4: Start the Environment

```bash
./scripts/xampp.sh start
```

### Step 5: Access Services

- **Website Homepage**: http://localhost
- **Database Management**: http://localhost:8080
  - Username: root
  - Password: root (can be modified in .env)

## 3. Command Instructions

### Environment Management

```bash
./scripts/xampp.sh [command]
```

**Available Commands**:

- `start` - Start Docker environment
- `stop` - Stop Docker environment
- `restart` - Restart Docker environment
- `status` - Show Docker environment status
- `shell` - Enter Apache container shell
- `mysql` - Enter MariaDB client
- `logs` - View Apache container logs
- `info` - Display environment information (component versions, access addresses)

**Usage Examples**:

```bash
# Start environment
./scripts/xampp.sh start

# View environment information
./scripts/xampp.sh info

# Enter container shell
./scripts/xampp.sh shell
```

### Project Management

```bash
./scripts/project-manager.sh [command] [subcommand] [parameters...]
```

#### Create a New Laravel Project

```bash
./scripts/project-manager.sh create [project-name] [options]
```

**Options**:

- `--vue` - Add Vue support and configure Vite
- `--db-name=DBNAME` - Specify database name (defaults to project name)

**Examples**:

```bash
# Create a basic Laravel project
./scripts/project-manager.sh create blog

# Create a Laravel project with Vue support
./scripts/project-manager.sh create blog --vue
```

#### Manage Apache Virtual Host Configuration

```bash
./scripts/project-manager.sh config [subcommand] [parameters...]
```

**Subcommands**:

- `list` - List all available Apache virtual host configurations
- `active` - Show currently active Apache virtual host configuration
- `enable [project-name]` - Enable specified Apache virtual host configuration
- `disable [project-name]` - Disable specified Apache virtual host configuration
- `switch [project-name]` - Switch to specified Apache virtual host configuration
- `basic` - Switch to default Apache virtual host configuration
- `create [project-name]` - Create new Apache virtual host configuration based on template

**Examples**:

```bash
# List all projects
./scripts/project-manager.sh config list

# Switch to specified project
./scripts/project-manager.sh config switch mysite
```

#### Manage Development Environment

```bash
./scripts/project-manager.sh dev [subcommand] [project-name]
```

**Subcommands**:

- `start [project-name]` - Start the development environment for the project
- `stop [project-name]` - Stop the development environment for the project
- `status` - Display all running development environments
- `fix-vite [project-name]` - Fix Vite configuration for the project

Starting the development environment will launch both:

- PHP Artisan Serve (access: http://localhost:8000)
- npm development server (access: http://localhost:5173)

**Example**:

```bash
# Start development environment for specified project
./scripts/project-manager.sh dev start myblog
```

## 4. Configuration Instructions

### Environment Variables

Environment configuration is in the `.env` file, containing the following main settings:

```bash
# MariaDB settings
MARIADB_ROOT_PASSWORD=root      # Database root password
MARIADB_DATABASE=laravel        # Default created database
MARIADB_USER=user               # Additional database user
MARIADB_PASSWORD=password       # Database user password
DB_PORT=3306                    # Database port mapping

# Web server settings
WEB_PORT=80                     # Web server port
SSL_PORT=443                    # SSL port
VITE_PORT=5173                  # Vite development server port
LARAVEL_PORT=8000               # Laravel development server port

# phpMyAdmin settings
PMA_PORT=8080                   # phpMyAdmin access port
```

If you modify these settings, you need to restart the environment: `./scripts/xampp.sh restart`

### Database Initialization

If you need to automatically execute SQL scripts when the database is first created, you can place `.sql` files in the `config/mariadb/init/` directory.

## 5. Project Development Guide

### Complete Workflow Example

#### Initial Setup

```bash
# Start environment
./scripts/xampp.sh start

# View environment information
./scripts/xampp.sh info
```

#### Create New Project

```bash
# Create a Laravel project with Vue support
./scripts/project-manager.sh create myblog --vue
```

#### Activate Project Configuration

```bash
# Switch to new project
./scripts/project-manager.sh config switch myblog
```

#### Development Workflow

```bash
# View Apache logs
./scripts/xampp.sh logs

# Enter container shell to execute commands
./scripts/xampp.sh shell

# Build frontend resources in the container
cd /var/www/html/myblog && npm run build

# Start development server
./scripts/project-manager.sh dev start myblog
```

### Common Laravel Commands

Execute in shell:

```bash
# Database migration
php artisan migrate

# Create controller
php artisan make:controller BookController

# Create model
php artisan make:model Book -m

# Run database seeder
php artisan db:seed

# Clear cache
php artisan cache:clear
```

## 6. Port Usage Description

This environment uses the following ports:

- 80: Apache HTTP
- 443: Apache HTTPS
- 8080: phpMyAdmin
- 3306: MariaDB
- 5173: Vite development server
- 8000: PHP Artisan server

## 7. Common Issues and Solutions

### 1. Cannot Access Project

**Solutions**:

- Confirm if the environment is running: `./scripts/xampp.sh status`

- Check Apache configuration:

  ```bash
  ./scripts/xampp.sh shell
  cat /etc/apache2/sites-enabled/000-default.conf
  service apache2 reload
  ```

- Try restarting the environment: `./scripts/xampp.sh restart`

### 2. Database Connection Error

**Solutions**:

- Check the `.env` file configuration of your project:

  ```
  DB_CONNECTION=mysql
  DB_HOST=mariadb
  DB_PORT=3306
  DB_DATABASE=laravel
  DB_USERNAME=root
  DB_PASSWORD=root
  ```

- Confirm if the MariaDB container is running: `./scripts/xampp.sh status`

### 3. Permission Issues

**Solutions**:

```bash
./scripts/xampp.sh shell
chmod -R 775 /var/www/html/your-project/storage
chmod -R 775 /var/www/html/your-project/bootstrap/cache
```

### 4. Code Changes Not Taking Effect

**Solutions**:

- Clear Laravel cache:

  ```bash
  cd /var/www/html/your-project
  php artisan cache:clear
  php artisan config:clear
  php artisan view:clear
  ```

- Force refresh the browser (Ctrl+F5 or Cmd+Shift+R)

### 5. Port Conflicts

**Solutions**:

- Modify port settings in the `.env` file, then restart the environment: `./scripts/xampp.sh restart`
