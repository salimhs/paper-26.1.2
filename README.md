<div align="center">

# Paper for Minecraft 26.1.2

[![Minecraft](https://img.shields.io/badge/Minecraft-26.1.2-green)](https://www.minecraft.net)
[![Java](https://img.shields.io/badge/Java-25%2B-orange)](https://adoptium.net)
[![License](https://img.shields.io/badge/License-MIT-blue)](#license)

**A ready-to-run Minecraft 26.1.2 server with optimized JVM configuration.**

[PaperMC](https://github.com/PaperMC/Paper) hasn't released a build for the 26.x update cycle yet.
This provides a vanilla 26.1.2 server with Paper-style [Aikar's flags](https://docs.papermc.io/paper/aikars-flags) so you can run the latest version now.
When Paper releases official 26.x builds, just swap the JAR — all configs carry over.

[**Download**](https://github.com/salimhs/paper-26.1.2/releases) · [**Quick Start**](#getting-started) · [**Configuration**](#configuration)

</div>

---

## Getting Started

### Requirements

- **Java 25+** — Minecraft 26.x requires Java 25 ([Download Temurin](https://adoptium.net/temurin/releases/?version=25))
- **4GB+ RAM** recommended (8GB default)

### Install

**Option A — Clone and run:**

```bash
git clone https://github.com/salimhs/paper-26.1.2.git
cd paper-26.1.2
chmod +x start.sh
./start.sh
```

**Option B — Download from [Releases](https://github.com/salimhs/paper-26.1.2/releases):**

1. Download `server.jar` from the latest release
2. Place it in an empty directory
3. Run: `java -jar server.jar --nogui`

### First Run

On first launch the server will:
1. Generate default config files (`server.properties`, `eula.txt`)
2. Accept the EULA by editing `eula.txt` → `eula=true`
3. Restart the server

## Configuration

### server.properties

Edit `server.properties` before starting. Key settings:

| Property | Default | Description |
|----------|---------|-------------|
| `server-port` | `25565` | Port to listen on |
| `gamemode` | `survival` | Default game mode |
| `difficulty` | `normal` | World difficulty |
| `max-players` | `20` | Max concurrent players |
| `view-distance` | `10` | Chunk render distance |
| `white-list` | `false` | Enable whitelist |

### JVM Flags

The included `start.sh` uses [Aikar's optimized flags](https://docs.papermc.io/paper/aikars-flags):

```bash
java -Xms8G -Xmx8G \
  -XX:+UseG1GC -XX:G1HeapRegionSize=16M \
  -XX:G1NewSizePercent=20 -XX:G1ReservePercent=20 \
  -XX:MaxGCPauseMillis=50 -XX:+AlwaysPreTouch \
  -XX:+UseStringDeduplication \
  -jar server.jar --nogui
```

Adjust `-Xms` and `-Xmx` to match your available RAM.

### Memory Guidelines

| RAM | Players | Notes |
|-----|---------|-------|
| 4GB | 1-5 | Minimum for a smooth experience |
| 8GB | 5-20 | Recommended default |
| 12GB+ | 20+ | Large servers or heavy modding |

## Upgrading from 1.21.x

1. Stop your current server
2. Copy `world/`, `world_nether/`, `world_the_end/` into the server directory
3. Start — world data upgrades automatically on first boot
4. Plugins are **not compatible** until Paper releases 26.x builds

## When Paper Releases 26.x

1. Download from [papermc.io/downloads](https://papermc.io/downloads)
2. Replace `server.jar`
3. Done — configs are fully compatible, no migration needed

## Java 25

Minecraft 26.x requires Java 25 (class file version 69). If you're on Java 21:

```bash
# Linux (no sudo needed)
curl -Lo jdk25.tar.gz 'https://api.adoptium.net/v3/binary/latest/25/ga/linux/x64/jdk/hotspot/normal/eclipse?project=jdk'
tar xzf jdk25.tar.gz
export JAVA_HOME=$PWD/jdk-25*
export PATH=$JAVA_HOME/bin:$PATH
java -version  # should show 25.x
```

Or install via your package manager — see [Adoptium installation guide](https://adoptium.net/installation/).

## License

MIT

---

<sub>Not affiliated with [PaperMC](https://github.com/PaperMC/Paper) or Mojang Studios. This repository exists to provide an easy server setup while official Paper builds for 26.x are pending.</sub>
