# House 1 - Didac's Temple
# Position: center ~0 ~0 ~67, door faces NORTH (toward courtyard)
# Banner: Red

# Foundation (15x15 polished deepslate)
fill ~-7 ~-1 ~60 ~7 ~-1 ~74 polished_deepslate

# Platform floor (15x15 bamboo planks = engawa/veranda)
fill ~-7 ~0 ~60 ~7 ~0 ~74 bamboo_planks

# Tatami interior floor (9x9 bamboo mosaic)
fill ~-4 ~0 ~63 ~4 ~0 ~71 bamboo_mosaic

# Wall line border (11x11 dark oak frame on floor)
fill ~-5 ~0 ~62 ~5 ~0 ~62 dark_oak_planks
fill ~-5 ~0 ~72 ~5 ~0 ~72 dark_oak_planks
fill ~-5 ~0 ~62 ~-5 ~0 ~72 dark_oak_planks
fill ~5 ~0 ~62 ~5 ~0 ~72 dark_oak_planks

# Entrance steps (3-wide, north side, 1 block out from platform)
setblock ~-1 ~0 ~59 bamboo_stairs[facing=south,half=bottom]
setblock ~0 ~0 ~59 bamboo_stairs[facing=south,half=bottom]
setblock ~1 ~0 ~59 bamboo_stairs[facing=south,half=bottom]

# Corner posts (dark oak log, 4 high)
fill ~-5 ~1 ~62 ~-5 ~4 ~62 dark_oak_log
fill ~5 ~1 ~62 ~5 ~4 ~62 dark_oak_log
fill ~-5 ~1 ~72 ~-5 ~4 ~72 dark_oak_log
fill ~5 ~1 ~72 ~5 ~4 ~72 dark_oak_log

# Mid-wall posts (every ~3 blocks)
# North wall (front)
fill ~-2 ~1 ~62 ~-2 ~4 ~62 dark_oak_log
fill ~2 ~1 ~62 ~2 ~4 ~62 dark_oak_log
# South wall (back)
fill ~-2 ~1 ~72 ~-2 ~4 ~72 dark_oak_log
fill ~2 ~1 ~72 ~2 ~4 ~72 dark_oak_log
# West wall
fill ~-5 ~1 ~65 ~-5 ~4 ~65 dark_oak_log
fill ~-5 ~1 ~69 ~-5 ~4 ~69 dark_oak_log
# East wall
fill ~5 ~1 ~65 ~5 ~4 ~65 dark_oak_log
fill ~5 ~1 ~69 ~5 ~4 ~69 dark_oak_log

# Top beam at Y+4 (continuous ring)
fill ~-5 ~4 ~62 ~5 ~4 ~62 dark_oak_planks
fill ~-5 ~4 ~72 ~5 ~4 ~72 dark_oak_planks
fill ~-5 ~4 ~62 ~-5 ~4 ~72 dark_oak_planks
fill ~5 ~4 ~62 ~5 ~4 ~72 dark_oak_planks

# Mid beam at Y+2 (horizontal divider)
fill ~-5 ~2 ~62 ~5 ~2 ~62 dark_oak_planks
fill ~-5 ~2 ~72 ~5 ~2 ~72 dark_oak_planks
fill ~-5 ~2 ~62 ~-5 ~2 ~72 dark_oak_planks
fill ~5 ~2 ~62 ~5 ~2 ~72 dark_oak_planks

# Shoji panels (bamboo mosaic infill at Y+1 and Y+3 between posts)
# North wall Y+1
fill ~-4 ~1 ~62 ~-3 ~1 ~62 bamboo_mosaic
fill ~-1 ~1 ~62 ~1 ~1 ~62 bamboo_mosaic
fill ~3 ~1 ~62 ~4 ~1 ~62 bamboo_mosaic
# North wall Y+3
fill ~-4 ~3 ~62 ~-3 ~3 ~62 bamboo_mosaic
fill ~-1 ~3 ~62 ~1 ~3 ~62 bamboo_mosaic
fill ~3 ~3 ~62 ~4 ~3 ~62 bamboo_mosaic
# South wall Y+1
fill ~-4 ~1 ~72 ~-3 ~1 ~72 bamboo_mosaic
fill ~-1 ~1 ~72 ~1 ~1 ~72 bamboo_mosaic
fill ~3 ~1 ~72 ~4 ~1 ~72 bamboo_mosaic
# South wall Y+3
fill ~-4 ~3 ~72 ~-3 ~3 ~72 bamboo_mosaic
fill ~-1 ~3 ~72 ~1 ~3 ~72 bamboo_mosaic
fill ~3 ~3 ~72 ~4 ~3 ~72 bamboo_mosaic
# West wall Y+1
fill ~-5 ~1 ~63 ~-5 ~1 ~64 bamboo_mosaic
fill ~-5 ~1 ~66 ~-5 ~1 ~68 bamboo_mosaic
fill ~-5 ~1 ~70 ~-5 ~1 ~71 bamboo_mosaic
# West wall Y+3
fill ~-5 ~3 ~63 ~-5 ~3 ~64 bamboo_mosaic
fill ~-5 ~3 ~66 ~-5 ~3 ~68 bamboo_mosaic
fill ~-5 ~3 ~70 ~-5 ~3 ~71 bamboo_mosaic
# East wall Y+1
fill ~5 ~1 ~63 ~5 ~1 ~64 bamboo_mosaic
fill ~5 ~1 ~66 ~5 ~1 ~68 bamboo_mosaic
fill ~5 ~1 ~70 ~5 ~1 ~71 bamboo_mosaic
# East wall Y+3
fill ~5 ~3 ~63 ~5 ~3 ~64 bamboo_mosaic
fill ~5 ~3 ~66 ~5 ~3 ~68 bamboo_mosaic
fill ~5 ~3 ~70 ~5 ~3 ~71 bamboo_mosaic

# Window lattice (bamboo trapdoors, open)
setblock ~-4 ~3 ~62 bamboo_trapdoor[facing=south,half=top,open=true]
setblock ~4 ~3 ~62 bamboo_trapdoor[facing=south,half=top,open=true]
setblock ~-5 ~3 ~67 bamboo_trapdoor[facing=east,half=top,open=true]
setblock ~5 ~3 ~67 bamboo_trapdoor[facing=west,half=top,open=true]
setblock ~-4 ~3 ~72 bamboo_trapdoor[facing=north,half=top,open=true]
setblock ~4 ~3 ~72 bamboo_trapdoor[facing=north,half=top,open=true]

# Interior air
fill ~-4 ~1 ~63 ~4 ~4 ~71 air

# Door (bamboo, north-facing)
setblock ~0 ~1 ~62 bamboo_door[facing=south,half=lower,hinge=left]
setblock ~0 ~2 ~62 bamboo_door[facing=south,half=upper,hinge=left]

# Veranda railing (bamboo fence, 3 sides, gap at entrance)
fill ~-7 ~1 ~60 ~-2 ~1 ~60 bamboo_fence
fill ~2 ~1 ~60 ~7 ~1 ~60 bamboo_fence
fill ~-7 ~1 ~74 ~7 ~1 ~74 bamboo_fence
fill ~-7 ~1 ~60 ~-7 ~1 ~74 bamboo_fence
fill ~7 ~1 ~60 ~7 ~1 ~74 bamboo_fence

# Roof Tier 1 (17x17 deepslate tile pagoda eave at Y+5)
fill ~-8 ~5 ~59 ~8 ~5 ~75 deepslate_tile_slab
# Eave edges (stairs facing inward)
fill ~-8 ~5 ~59 ~8 ~5 ~59 deepslate_tile_stairs[facing=south,half=bottom]
fill ~-8 ~5 ~75 ~8 ~5 ~75 deepslate_tile_stairs[facing=north,half=bottom]
fill ~-8 ~5 ~60 ~-8 ~5 ~74 deepslate_tile_stairs[facing=east,half=bottom]
fill ~8 ~5 ~60 ~8 ~5 ~74 deepslate_tile_stairs[facing=west,half=bottom]
# Corner upswept tips (pagoda curve)
setblock ~-8 ~6 ~59 deepslate_tile_stairs[facing=south,half=bottom]
setblock ~8 ~6 ~59 deepslate_tile_stairs[facing=south,half=bottom]
setblock ~-8 ~6 ~75 deepslate_tile_stairs[facing=north,half=bottom]
setblock ~8 ~6 ~75 deepslate_tile_stairs[facing=north,half=bottom]

# Attic fill (9x9 dark oak between tiers)
fill ~-4 ~6 ~63 ~4 ~6 ~71 dark_oak_planks

# Roof Tier 2 (13x13 at Y+7)
fill ~-6 ~7 ~61 ~6 ~7 ~73 deepslate_tile_slab
# Tier 2 eave edges
fill ~-6 ~7 ~61 ~6 ~7 ~61 deepslate_tile_stairs[facing=south,half=bottom]
fill ~-6 ~7 ~73 ~6 ~7 ~73 deepslate_tile_stairs[facing=north,half=bottom]
fill ~-6 ~7 ~62 ~-6 ~7 ~72 deepslate_tile_stairs[facing=east,half=bottom]
fill ~6 ~7 ~62 ~6 ~7 ~72 deepslate_tile_stairs[facing=west,half=bottom]
# Tier 2 corner upswept
setblock ~-6 ~8 ~61 deepslate_tile_stairs[facing=south,half=bottom]
setblock ~6 ~8 ~61 deepslate_tile_stairs[facing=south,half=bottom]
setblock ~-6 ~8 ~73 deepslate_tile_stairs[facing=north,half=bottom]
setblock ~6 ~8 ~73 deepslate_tile_stairs[facing=north,half=bottom]

# Roof finial
setblock ~0 ~8 ~67 gold_block
setblock ~0 ~9 ~67 lightning_rod

# Interior furnishings
setblock ~-3 ~1 ~71 red_bed[facing=north,part=head]
setblock ~-3 ~1 ~70 red_bed[facing=north,part=foot]
setblock ~3 ~1 ~71 chest[facing=west]
setblock ~3 ~1 ~69 crafting_table
setblock ~0 ~4 ~67 soul_lantern
setblock ~-2 ~1 ~69 potted_cherry_sapling

# Mini torii gate (1 block beyond platform, north side)
fill ~-2 ~0 ~58 ~-2 ~3 ~58 red_concrete
fill ~2 ~0 ~58 ~2 ~3 ~58 red_concrete
fill ~-3 ~4 ~58 ~3 ~4 ~58 red_concrete
fill ~-3 ~5 ~58 ~3 ~5 ~58 dark_oak_slab

# Stone lanterns flanking entrance
setblock ~-4 ~0 ~59 stone_brick_wall
setblock ~-4 ~1 ~59 smooth_stone_slab[type=double]
setblock ~-4 ~2 ~59 lantern
setblock ~4 ~0 ~59 stone_brick_wall
setblock ~4 ~1 ~59 smooth_stone_slab[type=double]
setblock ~4 ~2 ~59 lantern

# Cherry blossom tree (back-left veranda corner)
fill ~-6 ~1 ~73 ~-6 ~3 ~73 cherry_log
fill ~-7 ~4 ~72 ~-5 ~4 ~74 cherry_leaves
fill ~-6 ~5 ~72 ~-6 ~5 ~74 cherry_leaves
setblock ~-6 ~5 ~73 cherry_leaves
setblock ~-7 ~1 ~72 pink_petals
setblock ~-5 ~1 ~74 pink_petals

# Bamboo cluster (back-right veranda corner)
fill ~6 ~1 ~73 ~6 ~4 ~73 bamboo_block
fill ~7 ~1 ~73 ~7 ~3 ~73 bamboo_block
fill ~6 ~1 ~74 ~6 ~3 ~74 bamboo_block

# Banner (red, beside door on north face)
setblock ~1 ~3 ~62 red_wall_banner[facing=south]

# Name sign
setblock ~-1 ~3 ~62 bamboo_wall_sign[facing=south]{front_text:{messages:['{"text":"Didac"}','{"text":""}','{"text":""}','{"text":""}']}}
