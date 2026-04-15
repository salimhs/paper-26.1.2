#!/bin/bash
set -euo pipefail

# ─── Paper 26.1.2 Server Launch Script ───────────────────────────────
# Uses Aikar's optimized G1GC flags for Minecraft servers.
# https://docs.papermc.io/paper/aikars-flags
#
# Set MC_MEMORY env var to override heap size (default: 8G).
# Set MC_JAVA to override Java binary path.
# ──────────────────────────────────────────────────────────────────────

MEMORY="${MC_MEMORY:-8G}"
JAVA="${MC_JAVA:-java}"
JAR="server.jar"

# Verify Java version
JAVA_VERSION=$("$JAVA" -version 2>&1 | head -1 | grep -oP '"\K[0-9]+' || echo "0")
if [ "$JAVA_VERSION" -lt 25 ]; then
  echo "Error: Minecraft 26.x requires Java 25+. Found: Java $JAVA_VERSION"
  echo "Download: https://adoptium.net/temurin/releases/?version=25"
  exit 1
fi

if [ ! -f "$JAR" ]; then
  echo "Error: $JAR not found. Download it from:"
  echo "  https://github.com/salimhs/paper-26.1.2/releases"
  exit 1
fi

if [ ! -f "eula.txt" ] || ! grep -q "eula=true" eula.txt 2>/dev/null; then
  echo "eula=true" > eula.txt
  echo "EULA accepted."
fi

echo "Starting Minecraft 26.1.2 — ${MEMORY} heap"

exec "$JAVA" \
  -Xms${MEMORY} -Xmx${MEMORY} \
  -XX:+AlwaysPreTouch \
  -XX:+DisableExplicitGC \
  -XX:+ParallelRefProcEnabled \
  -XX:+PerfDisableSharedMem \
  -XX:+UnlockExperimentalVMOptions \
  -XX:+UseG1GC \
  -XX:G1HeapRegionSize=16M \
  -XX:G1NewSizePercent=20 \
  -XX:G1ReservePercent=20 \
  -XX:MaxGCPauseMillis=50 \
  -XX:MaxMetaspaceSize=512M \
  -XX:+UseStringDeduplication \
  -Dusing.aikars.flags=https://mcflags.emc.gs \
  -Daikars.new.flags=true \
  --enable-native-access=ALL-UNNAMED \
  -jar "$JAR" --nogui
