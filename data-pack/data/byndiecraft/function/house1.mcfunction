# House 1 - Didac's house
# Position: ~0 ~0 ~67, door faces NORTH (toward courtyard)
# Banner: Red

# Foundation (13x13 polished deepslate)
fill ~-6 ~-1 ~61 ~6 ~-1 ~73 polished_deepslate
fill ~-6 ~0 ~61 ~6 ~0 ~73 polished_deepslate

# Walls (spruce planks, 4 high)
fill ~-6 ~1 ~61 ~6 ~4 ~61 spruce_planks
fill ~-6 ~1 ~73 ~6 ~4 ~73 spruce_planks
fill ~-6 ~1 ~61 ~-6 ~4 ~73 spruce_planks
fill ~6 ~1 ~61 ~6 ~4 ~73 spruce_planks

# Interior air
fill ~-5 ~1 ~62 ~5 ~4 ~72 air

# Door (north-facing, at center of north wall)
setblock ~0 ~1 ~61 spruce_door[facing=south,half=lower,hinge=left]
setblock ~0 ~2 ~61 spruce_door[facing=south,half=upper,hinge=left]

# Windows (spruce fence)
setblock ~-3 ~2 ~61 spruce_fence
setblock ~-3 ~3 ~61 spruce_fence
setblock ~3 ~2 ~61 spruce_fence
setblock ~3 ~3 ~61 spruce_fence
setblock ~-6 ~2 ~67 spruce_fence
setblock ~-6 ~3 ~67 spruce_fence
setblock ~6 ~2 ~67 spruce_fence
setblock ~6 ~3 ~67 spruce_fence
setblock ~0 ~2 ~73 spruce_fence
setblock ~0 ~3 ~73 spruce_fence

# Roof - tier 1 (dark oak stairs, overhanging by 1)
fill ~-7 ~5 ~60 ~7 ~5 ~74 dark_oak_slab
fill ~-7 ~5 ~60 ~7 ~5 ~60 dark_oak_stairs[facing=south,half=bottom]
fill ~-7 ~5 ~74 ~7 ~5 ~74 dark_oak_stairs[facing=north,half=bottom]
fill ~-7 ~5 ~61 ~-7 ~5 ~73 dark_oak_stairs[facing=east,half=bottom]
fill ~7 ~5 ~61 ~7 ~5 ~73 dark_oak_stairs[facing=west,half=bottom]

# Roof - tier 2 (narrower)
fill ~-5 ~6 ~62 ~5 ~6 ~72 dark_oak_slab
fill ~-5 ~6 ~62 ~5 ~6 ~62 dark_oak_stairs[facing=south,half=bottom]
fill ~-5 ~6 ~72 ~5 ~6 ~72 dark_oak_stairs[facing=north,half=bottom]
fill ~-5 ~6 ~63 ~-5 ~6 ~71 dark_oak_stairs[facing=east,half=bottom]
fill ~5 ~6 ~63 ~5 ~6 ~71 dark_oak_stairs[facing=west,half=bottom]

# Roof peak
fill ~-3 ~7 ~64 ~3 ~7 ~70 dark_oak_planks
setblock ~0 ~8 ~67 amethyst_block
setblock ~0 ~9 ~67 amethyst_cluster[facing=up]

# Interior: bed, chest, crafting table, lantern
setblock ~-4 ~1 ~71 red_bed[facing=north,part=head]
setblock ~-4 ~1 ~72 red_bed[facing=north,part=foot]
setblock ~4 ~1 ~72 chest[facing=west]
setblock ~4 ~1 ~70 crafting_table
setblock ~0 ~4 ~67 soul_lantern

# Floor (spruce planks inside)
fill ~-5 ~0 ~62 ~5 ~0 ~72 spruce_planks

# Banner (red, beside door on north face)
setblock ~1 ~3 ~61 red_wall_banner[facing=south]

# Name sign
setblock ~-1 ~3 ~61 spruce_wall_sign[facing=south]{front_text:{messages:['{"text":"Didac"}','{"text":""}','{"text":""}','{"text":""}']}}

# Soul lanterns at entrance
setblock ~-2 ~3 ~60 soul_lantern
setblock ~2 ~3 ~60 soul_lantern
