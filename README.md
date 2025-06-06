# Awesoft PHP Docker Image

A minimal, production-ready PHP Docker image built on Alpine Linux

---

## Features

- Based on `php:8.4-alpine`
- Common extensions preinstalled:
  - Core: `bcmath`, `bz2`, `calendar`, `exif`, `gd`, `gettext`, `gmp`, `intl`, `mysqli`, `pdo_mysql`, `zip`, `soap`, `sockets`, `pcntl`, etc.
  - PECL: `xdebug`, `redis`, `pcov`
- Includes `composer` command (version 2.*)
- Clean non-root `app` user with UID `1000`

---

## Usage

```bash
docker run -it --rm awesoft/php:8.4 php -v
```

With volume mount:

```bash
docker run -it --rm -v $(pwd):/app awesoft/php:8.4
```
