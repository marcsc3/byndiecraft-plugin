# Neighborhood courtyard - centered at ~0 ~0 ~50
# Polished andesite courtyard floor (15x15) with fountain

# Courtyard floor
fill ~-7 ~-1 ~43 ~7 ~-1 ~57 polished_andesite

# Moss carpet border
fill ~-8 ~-1 ~42 ~8 ~-1 ~42 moss_block
fill ~-8 ~-1 ~58 ~8 ~-1 ~58 moss_block
fill ~-8 ~-1 ~42 ~-8 ~-1 ~58 moss_block
fill ~8 ~-1 ~42 ~8 ~-1 ~58 moss_block

# Fountain base (3x3 cobbled deepslate)
fill ~-1 ~0 ~49 ~1 ~0 ~51 cobbled_deepslate
fill ~-1 ~-1 ~49 ~1 ~-1 ~51 cobbled_deepslate

# Fountain water
setblock ~0 ~0 ~50 water

# Fountain pillar
setblock ~0 ~1 ~50 polished_deepslate
setblock ~0 ~2 ~50 polished_deepslate
setblock ~0 ~3 ~50 amethyst_block
setblock ~0 ~4 ~50 amethyst_cluster[facing=up]

# Fountain corner pillars
setblock ~-1 ~1 ~49 spruce_fence
setblock ~1 ~1 ~49 spruce_fence
setblock ~-1 ~1 ~51 spruce_fence
setblock ~1 ~1 ~51 spruce_fence

# Soul lanterns around fountain
setblock ~-1 ~2 ~49 soul_lantern
setblock ~1 ~2 ~49 soul_lantern
setblock ~-1 ~2 ~51 soul_lantern
setblock ~1 ~2 ~51 soul_lantern

# Courtyard benches (spruce stairs)
setblock ~-4 ~0 ~48 spruce_stairs[facing=east]
setblock ~-4 ~0 ~49 spruce_stairs[facing=east]
setblock ~4 ~0 ~51 spruce_stairs[facing=west]
setblock ~4 ~0 ~52 spruce_stairs[facing=west]
setblock ~-2 ~0 ~55 spruce_stairs[facing=north]
setblock ~-1 ~0 ~55 spruce_stairs[facing=north]
setblock ~1 ~0 ~45 spruce_stairs[facing=south]
setblock ~2 ~0 ~45 spruce_stairs[facing=south]

# Bamboo fences around courtyard edges
setblock ~-7 ~0 ~43 bamboo_fence
setblock ~-5 ~0 ~43 bamboo_fence
setblock ~-3 ~0 ~43 bamboo_fence
setblock ~7 ~0 ~43 bamboo_fence
setblock ~5 ~0 ~43 bamboo_fence
setblock ~3 ~0 ~43 bamboo_fence
setblock ~-7 ~0 ~57 bamboo_fence
setblock ~-5 ~0 ~57 bamboo_fence
setblock ~7 ~0 ~57 bamboo_fence
setblock ~5 ~0 ~57 bamboo_fence
