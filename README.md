# Awesoft PHP Docker Image

A minimal, production-ready PHP Docker image built on Alpine Linux

---

## Features

- Built on top of `php:*-alpine`
- Common extensions preinstalled:
  - `bcmath`
  - `bz2`
  - `calendar`
  - `exif`
  - `ftp`
  - `gd`
  - `gettext`
  - `gmp`
  - `intl`
  - `mysqli`
  - `pdo_mysql`
  - `shmop`
  - `soap`
  - `sodium`
  - `sockets`
  - `sysvmsg`
  - `sysvsem`
  - `sysvshm`
  - `tidy`
  - `xsl`
  - `zip`
  - `pcntl` 
  - `redis`
  - `xdebug` 
  - `pcov`
- Includes `composer` command (version `2.*`)
- Non-root `app` user with UID `1000`

---

## Usage

Run PHP CLI
```bash
docker run -it --rm ghcr.io/awesoft/php:8.4 php -v
```

Mount Project Directory
```bash
docker run -it --rm -v $(pwd):/app ghcr.io/awesoft/php:8.4
```

## Commands
| Command    | Description           |
|------------|-----------------------|
| `run-fpm`  | Start PHP-FPM service |
| `run-cron` | Start cron service    |


## Example `docker-compose.yml` file.
```yaml
services:
  cron:
    image: ghcr.io/awesoft/php:8.4
    command: run-cron
    environment:
      CRONTAB_FILE: /app/crontab.txt
    volumes:
      - .:/app
      - composer-data:/.composer
  fpm:
    image: ghcr.io/awesoft/php:8.4
    command: run-fpm
    volumes:
      - .:/app
      - composer-data:/.composer
volumes:
  composer-data:
```

## Notes
- By default, `xdebug` and `pcov` are disabled. Enable debugging by setting `DEBUG_ENABLED=1`.
- The `app` user ensures files are not created as `root`, making it safer for development and deployment.
- `composer` is ready to use out of the box with persistent cache via `/.composer`.
