# Ragtech Supervise Docker

Docker image for running Ragtech Supervise 8 inside a Debian 12 Slim container.

This image automatically downloads the official installer from Ragtech, extracts the package and installs Supervise without requiring user interaction.

## Features

- Debian 12 Slim
- Automatic download of the official installer
- Automatic installation
- Exposes TCP port **4470**
- Runs `supsvc` as PID 1
- Compatible with Docker Compose

---

# Build locally

Clone the repository:

```bash
git clone https://github.com/<user>/ragtech-supervise.git

cd ragtech-supervise
```

Build the image:

```bash
docker compose up -d --build
```

---

# Build Docker Compose

```yaml
version: "3.8"

services:

  supervise:
    container_name: supervise

    build:
      context: .
      dockerfile: Dockerfile

    restart: unless-stopped

    privileged: true

    devices:
      - /dev/ttyACM0:/dev/ttyACM0

    ports:
      - "4470:4470"
```

---

# Using Docker Hub

```yaml
version: "3.8"

services:

  supervise:
    container_name: supervise

    image: seuusuario/ragtech-supervise:latest

    restart: unless-stopped

    privileged: true

    devices:
      - /dev/ttyACM0:/dev/ttyACM0

    ports:
      - "4470:4470"
```

Start:

```bash
docker compose up -d
```

---

# USB Device

By default the compose file maps:

```
/dev/ttyACM0
```

For production environments it is recommended to create an **udev** rule using the device VID/PID and expose a persistent device name such as:

```
/dev/ragtech0
```

Then update compose:

```yaml
devices:
  - /dev/ragtech0:/dev/ragtech0
```

---

# Port

The Supervise service listens on:

```
4470/tcp
```

---

# Disclaimer

During the build process the official installer is downloaded directly from Ragtech servers.

All rights related to Supervise belong to Ragtech.
