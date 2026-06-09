# Imperial Castle Gate (south entrance at z=112)
# Massive gatehouse: 18-high towers, 11-wide passage, triple pagoda roofs

# Gate passage (11 wide x 8 high)
fill ~-5 ~0 ~110 ~5 ~8 ~114 air

# Left tower (x=-9 to -5, z=109-81, 18 high)
fill ~-9 ~0 ~109 ~-5 ~0 ~115 tuff_bricks
fill ~-9 ~1 ~109 ~-5 ~17 ~115 deepslate_bricks
fill ~-8 ~1 ~110 ~-6 ~16 ~114 air
fill ~-9 ~5 ~109 ~-5 ~5 ~115 polished_deepslate
fill ~-9 ~10 ~109 ~-5 ~10 ~115 polished_deepslate
fill ~-9 ~15 ~109 ~-5 ~15 ~115 polished_deepslate
fill ~-9 ~18 ~109 ~-5 ~18 ~115 polished_deepslate

# Right tower (x=5 to 9, z=109-81, mirror)
fill ~5 ~0 ~109 ~9 ~0 ~115 tuff_bricks
fill ~5 ~1 ~109 ~9 ~17 ~115 deepslate_bricks
fill ~6 ~1 ~110 ~8 ~16 ~114 air
fill ~5 ~5 ~109 ~9 ~5 ~115 polished_deepslate
fill ~5 ~10 ~109 ~9 ~10 ~115 polished_deepslate
fill ~5 ~15 ~109 ~9 ~15 ~115 polished_deepslate
fill ~5 ~18 ~109 ~9 ~18 ~115 polished_deepslate

# Pagoda roof tier 1 (y=7, widest flare)
fill ~-11 ~7 ~107 ~-3 ~7 ~117 dark_oak_slab
fill ~-11 ~7 ~107 ~-3 ~7 ~107 dark_oak_stairs[facing=south,half=bottom]
fill ~-11 ~7 ~117 ~-3 ~7 ~117 dark_oak_stairs[facing=north,half=bottom]
fill ~-11 ~7 ~108 ~-11 ~7 ~116 dark_oak_stairs[facing=east,half=bottom]
fill ~-3 ~7 ~108 ~-3 ~7 ~116 dark_oak_stairs[facing=west,half=bottom]
fill ~3 ~7 ~107 ~11 ~7 ~117 dark_oak_slab
fill ~3 ~7 ~107 ~11 ~7 ~107 dark_oak_stairs[facing=south,half=bottom]
fill ~3 ~7 ~117 ~11 ~7 ~117 dark_oak_stairs[facing=north,half=bottom]
fill ~3 ~7 ~108 ~3 ~7 ~116 dark_oak_stairs[facing=east,half=bottom]
fill ~11 ~7 ~108 ~11 ~7 ~116 dark_oak_stairs[facing=west,half=bottom]

# Pagoda roof tier 2 (y=13)
fill ~-10 ~13 ~108 ~-4 ~13 ~116 dark_oak_slab
fill ~-10 ~13 ~108 ~-4 ~13 ~108 dark_oak_stairs[facing=south,half=bottom]
fill ~-10 ~13 ~116 ~-4 ~13 ~116 dark_oak_stairs[facing=north,half=bottom]
fill ~-10 ~13 ~109 ~-10 ~13 ~115 dark_oak_stairs[facing=east,half=bottom]
fill ~-4 ~13 ~109 ~-4 ~13 ~115 dark_oak_stairs[facing=west,half=bottom]
fill ~4 ~13 ~108 ~10 ~13 ~116 dark_oak_slab
fill ~4 ~13 ~108 ~10 ~13 ~108 dark_oak_stairs[facing=south,half=bottom]
fill ~4 ~13 ~116 ~10 ~13 ~116 dark_oak_stairs[facing=north,half=bottom]
fill ~4 ~13 ~109 ~4 ~13 ~115 dark_oak_stairs[facing=east,half=bottom]
fill ~10 ~13 ~109 ~10 ~13 ~115 dark_oak_stairs[facing=west,half=bottom]

# Pagoda roof tier 3 / crown (y=19)
fill ~-10 ~19 ~108 ~-4 ~19 ~116 dark_oak_slab
fill ~-10 ~19 ~108 ~-4 ~19 ~108 dark_oak_stairs[facing=south,half=bottom]
fill ~-10 ~19 ~116 ~-4 ~19 ~116 dark_oak_stairs[facing=north,half=bottom]
fill ~-10 ~19 ~109 ~-10 ~19 ~115 dark_oak_stairs[facing=east,half=bottom]
fill ~-4 ~19 ~109 ~-4 ~19 ~115 dark_oak_stairs[facing=west,half=bottom]
fill ~4 ~19 ~108 ~10 ~19 ~116 dark_oak_slab
fill ~4 ~19 ~108 ~10 ~19 ~108 dark_oak_stairs[facing=south,half=bottom]
fill ~4 ~19 ~116 ~10 ~19 ~116 dark_oak_stairs[facing=north,half=bottom]
fill ~4 ~19 ~109 ~4 ~19 ~115 dark_oak_stairs[facing=east,half=bottom]
fill ~10 ~19 ~109 ~10 ~19 ~115 dark_oak_stairs[facing=west,half=bottom]

# Tower peaks (amethyst spires)
setblock ~-7 ~20 ~112 amethyst_block
setblock ~-7 ~21 ~112 amethyst_block
setblock ~-7 ~22 ~112 amethyst_cluster[facing=up]
setblock ~7 ~20 ~112 amethyst_block
setblock ~7 ~21 ~112 amethyst_block
setblock ~7 ~22 ~112 amethyst_cluster[facing=up]

# Connecting bridge (y=9-11)
fill ~-5 ~9 ~110 ~5 ~9 ~114 polished_deepslate
fill ~-5 ~10 ~110 ~5 ~11 ~110 deepslate_bricks
fill ~-5 ~10 ~114 ~5 ~11 ~114 deepslate_bricks
fill ~-4 ~10 ~111 ~4 ~11 ~113 air
fill ~-6 ~12 ~109 ~6 ~12 ~115 dark_oak_slab
fill ~-6 ~12 ~109 ~6 ~12 ~109 dark_oak_stairs[facing=south,half=bottom]
fill ~-6 ~12 ~115 ~6 ~12 ~115 dark_oak_stairs[facing=north,half=bottom]
fill ~-6 ~12 ~110 ~-6 ~12 ~114 dark_oak_stairs[facing=east,half=bottom]
fill ~6 ~12 ~110 ~6 ~12 ~114 dark_oak_stairs[facing=west,half=bottom]
setblock ~-2 ~10 ~110 spruce_fence
setblock ~0 ~10 ~110 spruce_fence
setblock ~2 ~10 ~110 spruce_fence
setblock ~-2 ~10 ~114 spruce_fence
setblock ~0 ~10 ~114 spruce_fence
setblock ~2 ~10 ~114 spruce_fence

# Gate arch
fill ~-5 ~8 ~109 ~5 ~8 ~115 polished_deepslate
fill ~-5 ~8 ~110 ~5 ~8 ~114 deepslate_bricks
setblock ~-5 ~8 ~112 deepslate_brick_stairs[facing=east,half=bottom]
setblock ~5 ~8 ~112 deepslate_brick_stairs[facing=west,half=bottom]

# Tower windows (multiple levels)
setblock ~-8 ~3 ~109 spruce_fence
setblock ~-7 ~3 ~109 spruce_fence
setblock ~-8 ~6 ~109 spruce_fence
setblock ~-7 ~6 ~109 spruce_fence
setblock ~-8 ~9 ~109 spruce_fence
setblock ~-7 ~9 ~109 spruce_fence
setblock ~-8 ~12 ~109 spruce_fence
setblock ~-7 ~12 ~109 spruce_fence
setblock ~-8 ~16 ~109 spruce_fence
setblock ~-7 ~16 ~109 spruce_fence
setblock ~7 ~3 ~109 spruce_fence
setblock ~8 ~3 ~109 spruce_fence
setblock ~7 ~6 ~109 spruce_fence
setblock ~8 ~6 ~109 spruce_fence
setblock ~7 ~9 ~109 spruce_fence
setblock ~8 ~9 ~109 spruce_fence
setblock ~7 ~12 ~109 spruce_fence
setblock ~8 ~12 ~109 spruce_fence
setblock ~7 ~16 ~109 spruce_fence
setblock ~8 ~16 ~109 spruce_fence

# Passage lighting (chains + lanterns)
setblock ~-4 ~8 ~110 chain[axis=y]
setblock ~-4 ~7 ~110 chain[axis=y]
setblock ~-4 ~6 ~110 soul_lantern
setblock ~4 ~8 ~110 chain[axis=y]
setblock ~4 ~7 ~110 chain[axis=y]
setblock ~4 ~6 ~110 soul_lantern
setblock ~-4 ~8 ~114 chain[axis=y]
setblock ~-4 ~7 ~114 chain[axis=y]
setblock ~-4 ~6 ~114 soul_lantern
setblock ~4 ~8 ~114 chain[axis=y]
setblock ~4 ~7 ~114 chain[axis=y]
setblock ~4 ~6 ~114 soul_lantern
setblock ~0 ~8 ~112 chain[axis=y]
setblock ~0 ~7 ~112 chain[axis=y]
setblock ~0 ~6 ~112 soul_lantern

# Banners (multiple levels)
setblock ~-7 ~4 ~109 red_wall_banner[facing=south]
setblock ~-6 ~4 ~109 purple_wall_banner[facing=south]
setblock ~7 ~4 ~109 red_wall_banner[facing=south]
setblock ~6 ~4 ~109 purple_wall_banner[facing=south]
setblock ~-8 ~8 ~109 red_wall_banner[facing=south]
setblock ~-6 ~8 ~109 purple_wall_banner[facing=south]
setblock ~8 ~8 ~109 red_wall_banner[facing=south]
setblock ~6 ~8 ~109 purple_wall_banner[facing=south]
setblock ~-7 ~14 ~109 red_wall_banner[facing=south]
setblock ~7 ~14 ~109 red_wall_banner[facing=south]

# Approach pillars (outside the gate at z=118)
fill ~-5 ~0 ~118 ~-5 ~7 ~118 deepslate_bricks
setblock ~-5 ~0 ~118 tuff_bricks
setblock ~-5 ~5 ~118 polished_deepslate
setblock ~-5 ~8 ~118 polished_deepslate
setblock ~-5 ~9 ~118 soul_lantern
setblock ~-5 ~6 ~118 red_wall_banner[facing=south]
fill ~5 ~0 ~118 ~5 ~7 ~118 deepslate_bricks
setblock ~5 ~0 ~118 tuff_bricks
setblock ~5 ~5 ~118 polished_deepslate
setblock ~5 ~8 ~118 polished_deepslate
setblock ~5 ~9 ~118 soul_lantern
setblock ~5 ~6 ~118 red_wall_banner[facing=south]

# Weathering detail
setblock ~-9 ~2 ~109 mossy_stone_bricks
setblock ~-9 ~3 ~110 cracked_deepslate_bricks
setblock ~-8 ~1 ~109 mossy_stone_bricks
setblock ~9 ~2 ~109 mossy_stone_bricks
setblock ~9 ~3 ~110 cracked_deepslate_bricks
setblock ~8 ~1 ~109 mossy_stone_bricks
setblock ~-9 ~2 ~115 mossy_stone_bricks
setblock ~9 ~2 ~115 mossy_stone_bricks

# Tower exterior lanterns
setblock ~-9 ~4 ~112 soul_lantern
setblock ~-9 ~11 ~112 soul_lantern
setblock ~-9 ~17 ~112 soul_lantern
setblock ~9 ~4 ~112 soul_lantern
setblock ~9 ~11 ~112 soul_lantern
setblock ~9 ~17 ~112 soul_lantern
