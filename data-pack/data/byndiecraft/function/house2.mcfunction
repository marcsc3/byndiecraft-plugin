# House 2 - Marc's Temple
# Position: center ~-20 ~0 ~50, door faces EAST (toward courtyard)
# Banner: Cyan

# Foundation (15x15 polished deepslate)
fill ~-27 ~-1 ~43 ~-13 ~-1 ~57 polished_deepslate

# Platform floor (15x15 bamboo planks)
fill ~-27 ~0 ~43 ~-13 ~0 ~57 bamboo_planks

# Tatami interior floor (9x9 bamboo mosaic)
fill ~-24 ~0 ~46 ~-16 ~0 ~54 bamboo_mosaic

# Wall line border (11x11 dark oak frame)
fill ~-25 ~0 ~45 ~-15 ~0 ~45 dark_oak_planks
fill ~-25 ~0 ~55 ~-15 ~0 ~55 dark_oak_planks
fill ~-25 ~0 ~45 ~-25 ~0 ~55 dark_oak_planks
fill ~-15 ~0 ~45 ~-15 ~0 ~55 dark_oak_planks

# Entrance steps (3-wide, east side, 1 block out from platform)
setblock ~-12 ~0 ~49 bamboo_stairs[facing=west,half=bottom]
setblock ~-12 ~0 ~50 bamboo_stairs[facing=west,half=bottom]
setblock ~-12 ~0 ~51 bamboo_stairs[facing=west,half=bottom]

# Corner posts (dark oak log, 4 high)
fill ~-25 ~1 ~45 ~-25 ~4 ~45 dark_oak_log
fill ~-15 ~1 ~45 ~-15 ~4 ~45 dark_oak_log
fill ~-25 ~1 ~55 ~-25 ~4 ~55 dark_oak_log
fill ~-15 ~1 ~55 ~-15 ~4 ~55 dark_oak_log

# Mid-wall posts
# East wall (front)
fill ~-15 ~1 ~48 ~-15 ~4 ~48 dark_oak_log
fill ~-15 ~1 ~52 ~-15 ~4 ~52 dark_oak_log
# West wall (back)
fill ~-25 ~1 ~48 ~-25 ~4 ~48 dark_oak_log
fill ~-25 ~1 ~52 ~-25 ~4 ~52 dark_oak_log
# North wall
fill ~-22 ~1 ~45 ~-22 ~4 ~45 dark_oak_log
fill ~-18 ~1 ~45 ~-18 ~4 ~45 dark_oak_log
# South wall
fill ~-22 ~1 ~55 ~-22 ~4 ~55 dark_oak_log
fill ~-18 ~1 ~55 ~-18 ~4 ~55 dark_oak_log

# Top beam at Y+4
fill ~-25 ~4 ~45 ~-15 ~4 ~45 dark_oak_planks
fill ~-25 ~4 ~55 ~-15 ~4 ~55 dark_oak_planks
fill ~-25 ~4 ~45 ~-25 ~4 ~55 dark_oak_planks
fill ~-15 ~4 ~45 ~-15 ~4 ~55 dark_oak_planks

# Mid beam at Y+2
fill ~-25 ~2 ~45 ~-15 ~2 ~45 dark_oak_planks
fill ~-25 ~2 ~55 ~-15 ~2 ~55 dark_oak_planks
fill ~-25 ~2 ~45 ~-25 ~2 ~55 dark_oak_planks
fill ~-15 ~2 ~45 ~-15 ~2 ~55 dark_oak_planks

# Shoji panels (bamboo mosaic Y+1 and Y+3)
# East wall Y+1
fill ~-15 ~1 ~46 ~-15 ~1 ~47 bamboo_mosaic
fill ~-15 ~1 ~49 ~-15 ~1 ~51 bamboo_mosaic
fill ~-15 ~1 ~53 ~-15 ~1 ~54 bamboo_mosaic
# East wall Y+3
fill ~-15 ~3 ~46 ~-15 ~3 ~47 bamboo_mosaic
fill ~-15 ~3 ~49 ~-15 ~3 ~51 bamboo_mosaic
fill ~-15 ~3 ~53 ~-15 ~3 ~54 bamboo_mosaic
# West wall Y+1
fill ~-25 ~1 ~46 ~-25 ~1 ~47 bamboo_mosaic
fill ~-25 ~1 ~49 ~-25 ~1 ~51 bamboo_mosaic
fill ~-25 ~1 ~53 ~-25 ~1 ~54 bamboo_mosaic
# West wall Y+3
fill ~-25 ~3 ~46 ~-25 ~3 ~47 bamboo_mosaic
fill ~-25 ~3 ~49 ~-25 ~3 ~51 bamboo_mosaic
fill ~-25 ~3 ~53 ~-25 ~3 ~54 bamboo_mosaic
# North wall Y+1
fill ~-24 ~1 ~45 ~-23 ~1 ~45 bamboo_mosaic
fill ~-21 ~1 ~45 ~-19 ~1 ~45 bamboo_mosaic
fill ~-17 ~1 ~45 ~-16 ~1 ~45 bamboo_mosaic
# North wall Y+3
fill ~-24 ~3 ~45 ~-23 ~3 ~45 bamboo_mosaic
fill ~-21 ~3 ~45 ~-19 ~3 ~45 bamboo_mosaic
fill ~-17 ~3 ~45 ~-16 ~3 ~45 bamboo_mosaic
# South wall Y+1
fill ~-24 ~1 ~55 ~-23 ~1 ~55 bamboo_mosaic
fill ~-21 ~1 ~55 ~-19 ~1 ~55 bamboo_mosaic
fill ~-17 ~1 ~55 ~-16 ~1 ~55 bamboo_mosaic
# South wall Y+3
fill ~-24 ~3 ~55 ~-23 ~3 ~55 bamboo_mosaic
fill ~-21 ~3 ~55 ~-19 ~3 ~55 bamboo_mosaic
fill ~-17 ~3 ~55 ~-16 ~3 ~55 bamboo_mosaic

# Window lattice
setblock ~-15 ~3 ~46 bamboo_trapdoor[facing=west,half=top,open=true]
setblock ~-15 ~3 ~54 bamboo_trapdoor[facing=west,half=top,open=true]
setblock ~-25 ~3 ~46 bamboo_trapdoor[facing=east,half=top,open=true]
setblock ~-25 ~3 ~54 bamboo_trapdoor[facing=east,half=top,open=true]
setblock ~-20 ~3 ~45 bamboo_trapdoor[facing=south,half=top,open=true]
setblock ~-20 ~3 ~55 bamboo_trapdoor[facing=north,half=top,open=true]

# Interior air
fill ~-24 ~1 ~46 ~-16 ~4 ~54 air

# Door (bamboo, east-facing)
setblock ~-15 ~1 ~50 bamboo_door[facing=west,half=lower,hinge=left]
setblock ~-15 ~2 ~50 bamboo_door[facing=west,half=upper,hinge=left]

# Veranda railing (3 sides, gap at east entrance)
fill ~-13 ~1 ~43 ~-13 ~1 ~48 bamboo_fence
fill ~-13 ~1 ~52 ~-13 ~1 ~57 bamboo_fence
fill ~-27 ~1 ~43 ~-27 ~1 ~57 bamboo_fence
fill ~-27 ~1 ~43 ~-13 ~1 ~43 bamboo_fence
fill ~-27 ~1 ~57 ~-13 ~1 ~57 bamboo_fence

# Roof Tier 1 (17x17 at Y+5)
fill ~-28 ~5 ~42 ~-12 ~5 ~58 deepslate_tile_slab
fill ~-28 ~5 ~42 ~-12 ~5 ~42 deepslate_tile_stairs[facing=south,half=bottom]
fill ~-28 ~5 ~58 ~-12 ~5 ~58 deepslate_tile_stairs[facing=north,half=bottom]
fill ~-28 ~5 ~43 ~-28 ~5 ~57 deepslate_tile_stairs[facing=east,half=bottom]
fill ~-12 ~5 ~43 ~-12 ~5 ~57 deepslate_tile_stairs[facing=west,half=bottom]
# Corner upswept
setblock ~-28 ~6 ~42 deepslate_tile_stairs[facing=south,half=bottom]
setblock ~-12 ~6 ~42 deepslate_tile_stairs[facing=south,half=bottom]
setblock ~-28 ~6 ~58 deepslate_tile_stairs[facing=north,half=bottom]
setblock ~-12 ~6 ~58 deepslate_tile_stairs[facing=north,half=bottom]

# Attic fill (9x9 dark oak)
fill ~-24 ~6 ~46 ~-16 ~6 ~54 dark_oak_planks

# Roof Tier 2 (13x13 at Y+7)
fill ~-26 ~7 ~44 ~-14 ~7 ~56 deepslate_tile_slab
fill ~-26 ~7 ~44 ~-14 ~7 ~44 deepslate_tile_stairs[facing=south,half=bottom]
fill ~-26 ~7 ~56 ~-14 ~7 ~56 deepslate_tile_stairs[facing=north,half=bottom]
fill ~-26 ~7 ~45 ~-26 ~7 ~55 deepslate_tile_stairs[facing=east,half=bottom]
fill ~-14 ~7 ~45 ~-14 ~7 ~55 deepslate_tile_stairs[facing=west,half=bottom]
# Tier 2 corner upswept
setblock ~-26 ~8 ~44 deepslate_tile_stairs[facing=south,half=bottom]
setblock ~-14 ~8 ~44 deepslate_tile_stairs[facing=south,half=bottom]
setblock ~-26 ~8 ~56 deepslate_tile_stairs[facing=north,half=bottom]
setblock ~-14 ~8 ~56 deepslate_tile_stairs[facing=north,half=bottom]

# Roof finial
setblock ~-20 ~8 ~50 gold_block
setblock ~-20 ~9 ~50 lightning_rod

# Interior furnishings
setblock ~-24 ~1 ~53 cyan_bed[facing=north,part=head]
setblock ~-24 ~1 ~54 cyan_bed[facing=north,part=foot]
setblock ~-24 ~1 ~46 chest[facing=east]
setblock ~-22 ~1 ~46 crafting_table
setblock ~-20 ~4 ~50 soul_lantern
setblock ~-22 ~1 ~48 potted_cherry_sapling

# Mini torii gate (1 block beyond platform, east side)
fill ~-11 ~0 ~48 ~-11 ~3 ~48 red_concrete
fill ~-11 ~0 ~52 ~-11 ~3 ~52 red_concrete
fill ~-11 ~4 ~47 ~-11 ~4 ~53 red_concrete
fill ~-11 ~5 ~47 ~-11 ~5 ~53 dark_oak_slab

# Stone lanterns
setblock ~-12 ~0 ~46 stone_brick_wall
setblock ~-12 ~1 ~46 smooth_stone_slab[type=double]
setblock ~-12 ~2 ~46 lantern
setblock ~-12 ~0 ~54 stone_brick_wall
setblock ~-12 ~1 ~54 smooth_stone_slab[type=double]
setblock ~-12 ~2 ~54 lantern

# Cherry blossom tree (back-left veranda corner)
fill ~-26 ~1 ~44 ~-26 ~3 ~44 cherry_log
fill ~-27 ~4 ~43 ~-25 ~4 ~45 cherry_leaves
fill ~-26 ~5 ~43 ~-26 ~5 ~45 cherry_leaves
setblock ~-26 ~5 ~44 cherry_leaves
setblock ~-27 ~1 ~45 pink_petals
setblock ~-25 ~1 ~43 pink_petals

# Bamboo cluster (back-right veranda corner)
fill ~-26 ~1 ~56 ~-26 ~4 ~56 bamboo_block
fill ~-27 ~1 ~56 ~-27 ~3 ~56 bamboo_block
fill ~-26 ~1 ~57 ~-26 ~3 ~57 bamboo_block

# Banner (cyan, beside door on east face)
setblock ~-15 ~3 ~51 cyan_wall_banner[facing=west]

# Name sign
setblock ~-15 ~3 ~49 bamboo_wall_sign[facing=west]{front_text:{messages:['{"text":"Marc"}','{"text":""}','{"text":""}','{"text":""}']}}
