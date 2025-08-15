# librespot-pi

Docker container for [librespot](https://github.com/librespot-org/librespot) on Raspberry Pi 5 with a HifiBerry DAC+ 

## Usage

First, clone this repo, then:

```bash
docker-compose up
```

OAuth authentication required on first run. Credentials cached in `./auth-cache/`.

Alternatively, you may just pull this docker image directly:

```bash
docker pull ghcr.io/salmanmohammadi/librespot-pi:main
```
