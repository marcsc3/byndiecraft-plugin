# House 4 - Armando's Temple
# Position: center ~12 ~0 ~33, door faces SOUTH (toward courtyard)
# Banner: Purple

# Foundation (15x15 polished deepslate)
fill ~5 ~-1 ~26 ~19 ~-1 ~40 polished_deepslate

# Platform floor (15x15 bamboo planks)
fill ~5 ~0 ~26 ~19 ~0 ~40 bamboo_planks

# Tatami interior floor (9x9 bamboo mosaic)
fill ~8 ~0 ~29 ~16 ~0 ~37 bamboo_mosaic

# Wall line border (11x11 dark oak frame)
fill ~7 ~0 ~28 ~17 ~0 ~28 dark_oak_planks
fill ~7 ~0 ~38 ~17 ~0 ~38 dark_oak_planks
fill ~7 ~0 ~28 ~7 ~0 ~38 dark_oak_planks
fill ~17 ~0 ~28 ~17 ~0 ~38 dark_oak_planks

# Entrance steps (3-wide, south side)
setblock ~11 ~0 ~41 bamboo_stairs[facing=north,half=bottom]
setblock ~12 ~0 ~41 bamboo_stairs[facing=north,half=bottom]
setblock ~13 ~0 ~41 bamboo_stairs[facing=north,half=bottom]

# Corner posts (dark oak log, 4 high)
fill ~7 ~1 ~28 ~7 ~4 ~28 dark_oak_log
fill ~17 ~1 ~28 ~17 ~4 ~28 dark_oak_log
fill ~7 ~1 ~38 ~7 ~4 ~38 dark_oak_log
fill ~17 ~1 ~38 ~17 ~4 ~38 dark_oak_log

# Mid-wall posts
# South wall (front)
fill ~10 ~1 ~38 ~10 ~4 ~38 dark_oak_log
fill ~14 ~1 ~38 ~14 ~4 ~38 dark_oak_log
# North wall (back)
fill ~10 ~1 ~28 ~10 ~4 ~28 dark_oak_log
fill ~14 ~1 ~28 ~14 ~4 ~28 dark_oak_log
# West wall
fill ~7 ~1 ~31 ~7 ~4 ~31 dark_oak_log
fill ~7 ~1 ~35 ~7 ~4 ~35 dark_oak_log
# East wall
fill ~17 ~1 ~31 ~17 ~4 ~31 dark_oak_log
fill ~17 ~1 ~35 ~17 ~4 ~35 dark_oak_log

# Top beam at Y+4
fill ~7 ~4 ~28 ~17 ~4 ~28 dark_oak_planks
fill ~7 ~4 ~38 ~17 ~4 ~38 dark_oak_planks
fill ~7 ~4 ~28 ~7 ~4 ~38 dark_oak_planks
fill ~17 ~4 ~28 ~17 ~4 ~38 dark_oak_planks

# Mid beam at Y+2
fill ~7 ~2 ~28 ~17 ~2 ~28 dark_oak_planks
fill ~7 ~2 ~38 ~17 ~2 ~38 dark_oak_planks
fill ~7 ~2 ~28 ~7 ~2 ~38 dark_oak_planks
fill ~17 ~2 ~28 ~17 ~2 ~38 dark_oak_planks

# Shoji panels (bamboo mosaic Y+1 and Y+3)
# South wall Y+1
fill ~8 ~1 ~38 ~9 ~1 ~38 bamboo_mosaic
fill ~11 ~1 ~38 ~13 ~1 ~38 bamboo_mosaic
fill ~15 ~1 ~38 ~16 ~1 ~38 bamboo_mosaic
# South wall Y+3
fill ~8 ~3 ~38 ~9 ~3 ~38 bamboo_mosaic
fill ~11 ~3 ~38 ~13 ~3 ~38 bamboo_mosaic
fill ~15 ~3 ~38 ~16 ~3 ~38 bamboo_mosaic
# North wall Y+1
fill ~8 ~1 ~28 ~9 ~1 ~28 bamboo_mosaic
fill ~11 ~1 ~28 ~13 ~1 ~28 bamboo_mosaic
fill ~15 ~1 ~28 ~16 ~1 ~28 bamboo_mosaic
# North wall Y+3
fill ~8 ~3 ~28 ~9 ~3 ~28 bamboo_mosaic
fill ~11 ~3 ~28 ~13 ~3 ~28 bamboo_mosaic
fill ~15 ~3 ~28 ~16 ~3 ~28 bamboo_mosaic
# West wall Y+1
fill ~7 ~1 ~29 ~7 ~1 ~30 bamboo_mosaic
fill ~7 ~1 ~32 ~7 ~1 ~34 bamboo_mosaic
fill ~7 ~1 ~36 ~7 ~1 ~37 bamboo_mosaic
# West wall Y+3
fill ~7 ~3 ~29 ~7 ~3 ~30 bamboo_mosaic
fill ~7 ~3 ~32 ~7 ~3 ~34 bamboo_mosaic
fill ~7 ~3 ~36 ~7 ~3 ~37 bamboo_mosaic
# East wall Y+1
fill ~17 ~1 ~29 ~17 ~1 ~30 bamboo_mosaic
fill ~17 ~1 ~32 ~17 ~1 ~34 bamboo_mosaic
fill ~17 ~1 ~36 ~17 ~1 ~37 bamboo_mosaic
# East wall Y+3
fill ~17 ~3 ~29 ~17 ~3 ~30 bamboo_mosaic
fill ~17 ~3 ~32 ~17 ~3 ~34 bamboo_mosaic
fill ~17 ~3 ~36 ~17 ~3 ~37 bamboo_mosaic

# Window lattice
setblock ~8 ~3 ~38 bamboo_trapdoor[facing=north,half=top,open=true]
setblock ~16 ~3 ~38 bamboo_trapdoor[facing=north,half=top,open=true]
setblock ~7 ~3 ~33 bamboo_trapdoor[facing=east,half=top,open=true]
setblock ~17 ~3 ~33 bamboo_trapdoor[facing=west,half=top,open=true]
setblock ~8 ~3 ~28 bamboo_trapdoor[facing=south,half=top,open=true]
setblock ~16 ~3 ~28 bamboo_trapdoor[facing=south,half=top,open=true]

# Interior air
fill ~8 ~1 ~29 ~16 ~4 ~37 air

# Door (bamboo, south-facing)
setblock ~12 ~1 ~38 bamboo_door[facing=north,half=lower,hinge=left]
setblock ~12 ~2 ~38 bamboo_door[facing=north,half=upper,hinge=left]

# Veranda railing (3 sides, gap at south entrance)
fill ~5 ~1 ~40 ~10 ~1 ~40 bamboo_fence
fill ~14 ~1 ~40 ~19 ~1 ~40 bamboo_fence
fill ~5 ~1 ~26 ~19 ~1 ~26 bamboo_fence
fill ~5 ~1 ~26 ~5 ~1 ~40 bamboo_fence
fill ~19 ~1 ~26 ~19 ~1 ~40 bamboo_fence

# Roof Tier 1 (17x17 at Y+5)
fill ~4 ~5 ~25 ~20 ~5 ~41 deepslate_tile_slab
fill ~4 ~5 ~25 ~20 ~5 ~25 deepslate_tile_stairs[facing=south,half=bottom]
fill ~4 ~5 ~41 ~20 ~5 ~41 deepslate_tile_stairs[facing=north,half=bottom]
fill ~4 ~5 ~26 ~4 ~5 ~40 deepslate_tile_stairs[facing=east,half=bottom]
fill ~20 ~5 ~26 ~20 ~5 ~40 deepslate_tile_stairs[facing=west,half=bottom]
# Corner upswept
setblock ~4 ~6 ~25 deepslate_tile_stairs[facing=south,half=bottom]
setblock ~20 ~6 ~25 deepslate_tile_stairs[facing=south,half=bottom]
setblock ~4 ~6 ~41 deepslate_tile_stairs[facing=north,half=bottom]
setblock ~20 ~6 ~41 deepslate_tile_stairs[facing=north,half=bottom]

# Attic fill (9x9 dark oak)
fill ~8 ~6 ~29 ~16 ~6 ~37 dark_oak_planks

# Roof Tier 2 (13x13 at Y+7)
fill ~6 ~7 ~27 ~18 ~7 ~39 deepslate_tile_slab
fill ~6 ~7 ~27 ~18 ~7 ~27 deepslate_tile_stairs[facing=south,half=bottom]
fill ~6 ~7 ~39 ~18 ~7 ~39 deepslate_tile_stairs[facing=north,half=bottom]
fill ~6 ~7 ~28 ~6 ~7 ~38 deepslate_tile_stairs[facing=east,half=bottom]
fill ~18 ~7 ~28 ~18 ~7 ~38 deepslate_tile_stairs[facing=west,half=bottom]
# Tier 2 corner upswept
setblock ~6 ~8 ~27 deepslate_tile_stairs[facing=south,half=bottom]
setblock ~18 ~8 ~27 deepslate_tile_stairs[facing=south,half=bottom]
setblock ~6 ~8 ~39 deepslate_tile_stairs[facing=north,half=bottom]
setblock ~18 ~8 ~39 deepslate_tile_stairs[facing=north,half=bottom]

# Roof finial
setblock ~12 ~8 ~33 gold_block
setblock ~12 ~9 ~33 lightning_rod

# Interior furnishings
setblock ~15 ~1 ~29 purple_bed[facing=south,part=head]
setblock ~15 ~1 ~30 purple_bed[facing=south,part=foot]
setblock ~9 ~1 ~29 chest[facing=south]
setblock ~9 ~1 ~31 crafting_table
setblock ~12 ~4 ~33 soul_lantern
setblock ~10 ~1 ~31 potted_cherry_sapling

# Mini torii gate (1 block beyond platform, south side)
fill ~10 ~0 ~42 ~10 ~3 ~42 red_concrete
fill ~14 ~0 ~42 ~14 ~3 ~42 red_concrete
fill ~9 ~4 ~42 ~15 ~4 ~42 red_concrete
fill ~9 ~5 ~42 ~15 ~5 ~42 dark_oak_slab

# Stone lanterns
setblock ~8 ~0 ~41 stone_brick_wall
setblock ~8 ~1 ~41 smooth_stone_slab[type=double]
setblock ~8 ~2 ~41 lantern
setblock ~16 ~0 ~41 stone_brick_wall
setblock ~16 ~1 ~41 smooth_stone_slab[type=double]
setblock ~16 ~2 ~41 lantern

# Cherry blossom tree (back-left veranda corner)
fill ~6 ~1 ~27 ~6 ~3 ~27 cherry_log
fill ~5 ~4 ~26 ~7 ~4 ~28 cherry_leaves
fill ~6 ~5 ~26 ~6 ~5 ~28 cherry_leaves
setblock ~6 ~5 ~27 cherry_leaves
setblock ~5 ~1 ~28 pink_petals
setblock ~7 ~1 ~26 pink_petals

# Bamboo cluster (back-right veranda corner)
fill ~18 ~1 ~27 ~18 ~4 ~27 bamboo_block
fill ~19 ~1 ~27 ~19 ~3 ~27 bamboo_block
fill ~18 ~1 ~26 ~18 ~3 ~26 bamboo_block

# Banner (purple, beside door on south face)
setblock ~13 ~3 ~38 purple_wall_banner[facing=north]

# Name sign
setblock ~11 ~3 ~38 bamboo_wall_sign[facing=north]{front_text:{messages:['{"text":"Armando"}','{"text":""}','{"text":""}','{"text":""}']}}
