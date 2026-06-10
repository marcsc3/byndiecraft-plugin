# Clear the build area in chunks (fill limit is 32768 blocks per command)
# Total area: x=-55 to 55, y=-1 to 30, z=-45 to 125
# Split into vertical slices to stay under limit

# Ground level
fill ~-55 ~-1 ~-45 ~55 ~-1 ~0 grass_block
fill ~-55 ~-1 ~1 ~55 ~-1 ~60 grass_block
fill ~-55 ~-1 ~61 ~55 ~-1 ~125 grass_block

# Clear air: y=0 to y=10
fill ~-55 ~0 ~-45 ~55 ~10 ~0 air
fill ~-55 ~0 ~1 ~55 ~10 ~60 air
fill ~-55 ~0 ~61 ~55 ~10 ~125 air

# Clear air: y=11 to y=20
fill ~-55 ~11 ~-45 ~55 ~20 ~0 air
fill ~-55 ~11 ~1 ~55 ~20 ~60 air
fill ~-55 ~11 ~61 ~55 ~20 ~125 air

# Clear air: y=21 to y=30
fill ~-55 ~21 ~-45 ~55 ~30 ~0 air
fill ~-55 ~21 ~1 ~55 ~30 ~60 air
fill ~-55 ~21 ~61 ~55 ~30 ~125 air

# Clear sky area for Ronaldo cloud face (y=50 to y=110, z=40 plane)
fill ~-25 ~50 ~40 ~25 ~110 ~40 air
