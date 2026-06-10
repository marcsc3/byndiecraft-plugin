#!/bin/bash
set -e

SERVER_DIR="/minecraft"
WORLD_DIR="$SERVER_DIR/world"
PLUGINS_DIR="$SERVER_DIR/plugins"
DATAPACK_DEST="$WORLD_DIR/datapacks/byndiecraft"

echo "Building plugin..."
mvn package -q -DskipTests

echo "Deploying JAR..."
cp target/byndiecraft-plugin-*-SNAPSHOT.jar "$PLUGINS_DIR/"

echo "Deploying data-pack..."
rm -rf "$DATAPACK_DEST"
cp -r data-pack "$DATAPACK_DEST"

echo "✓ Plugin JAR deployed to $PLUGINS_DIR"
echo "✓ Data-pack deployed to $DATAPACK_DEST"
echo "Run /reload confirm in-game to apply changes"
