#!/bin/bash
set -e

SERVER_DIR="../"
WORLD_DIR="$SERVER_DIR/world"
PLUGINS_DIR="$SERVER_DIR/plugins"
DATAPACK_DEST="$WORLD_DIR/datapacks/byndiecraft"

cd /home/ubuntu/minecraft/byndiecraft-plugin
git pull
mvn clean package
cp target/byndiecraft-plugin-1.0.0-SNAPSHOT.jar "$PLUGINS_DIR/"

echo "Deploying data-pack..."
rm -rf "$DATAPACK_DEST"
cp -r data-pack "$DATAPACK_DEST"

echo "✓ Plugin JAR deployed to $PLUGINS_DIR"
echo "✓ Data-pack deployed to $DATAPACK_DEST"
echo "Run /reload confirm in-game to apply changes"
