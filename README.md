# Awesoft PHP Docker Image

A minimal, production-ready PHP Docker image built on Alpine Linux

---

## Features

- Built on top of `php:8.*-alpine`
- Extensions preinstalled:
  - Core: 
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
    - `zip` 
    - `soap` 
    - `sodium` 
    - `sockets` 
    - `pcntl`
  - PECL: 
    - `xdebug` 
    - `redis` 
    - `pcov`
  - Zend:
    - `OPcache`
- Includes `composer` command (version `2.8`)
- Non-root `app` user with UID `1000`

---

## Usage

```bash
docker run -it --rm -u app awesoft/php:8.4 php -v
```

With volume mount:

```bash
docker run -it --rm -u app -v $(pwd):/app awesoft/php:8.4
```

By default, `xdebug` and `pcov` extensions are disabled.
To enable, set the environment variable `DEBUG_ENABLED` with the value of `1`

