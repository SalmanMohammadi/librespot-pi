# librespot-pi

Docker container for [librespot](https://github.com/librespot-org/librespot) on Raspberry Pi with hardware volume control via ALSA mixer.

Cross-compiles librespot for ARM64 using multi-stage Docker build, enabling hardware mixer control for DACs and audio HATs instead of software volume attenuation.

## Usage

```bash
docker-compose up
```

OAuth authentication required on first run. Credentials cached in `./auth-cache/`.
