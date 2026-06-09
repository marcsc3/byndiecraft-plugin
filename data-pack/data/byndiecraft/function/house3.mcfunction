# House 3 - Igor's house
# Position: ~-12 ~0 ~33, door faces SOUTH (toward courtyard)
# Banner: Green

# Foundation (13x13 polished deepslate)
fill ~-18 ~-1 ~27 ~-6 ~-1 ~39 polished_deepslate
fill ~-18 ~0 ~27 ~-6 ~0 ~39 polished_deepslate

# Walls (spruce planks, 4 high)
fill ~-18 ~1 ~27 ~-6 ~4 ~27 spruce_planks
fill ~-18 ~1 ~39 ~-6 ~4 ~39 spruce_planks
fill ~-18 ~1 ~27 ~-18 ~4 ~39 spruce_planks
fill ~-6 ~1 ~27 ~-6 ~4 ~39 spruce_planks

# Interior air
fill ~-17 ~1 ~28 ~-7 ~4 ~38 air

# Door (south-facing, center of south wall)
setblock ~-12 ~1 ~39 spruce_door[facing=north,half=lower,hinge=left]
setblock ~-12 ~2 ~39 spruce_door[facing=north,half=upper,hinge=left]

# Windows (spruce fence)
setblock ~-15 ~2 ~39 spruce_fence
setblock ~-15 ~3 ~39 spruce_fence
setblock ~-9 ~2 ~39 spruce_fence
setblock ~-9 ~3 ~39 spruce_fence
setblock ~-18 ~2 ~33 spruce_fence
setblock ~-18 ~3 ~33 spruce_fence
setblock ~-6 ~2 ~33 spruce_fence
setblock ~-6 ~3 ~33 spruce_fence
setblock ~-12 ~2 ~27 spruce_fence
setblock ~-12 ~3 ~27 spruce_fence

# Roof - tier 1 (dark oak stairs, overhanging by 1)
fill ~-19 ~5 ~26 ~-5 ~5 ~40 dark_oak_slab
fill ~-19 ~5 ~26 ~-5 ~5 ~26 dark_oak_stairs[facing=south,half=bottom]
fill ~-19 ~5 ~40 ~-5 ~5 ~40 dark_oak_stairs[facing=north,half=bottom]
fill ~-19 ~5 ~27 ~-19 ~5 ~39 dark_oak_stairs[facing=east,half=bottom]
fill ~-5 ~5 ~27 ~-5 ~5 ~39 dark_oak_stairs[facing=west,half=bottom]

# Roof - tier 2 (narrower)
fill ~-17 ~6 ~28 ~-7 ~6 ~38 dark_oak_slab
fill ~-17 ~6 ~28 ~-7 ~6 ~28 dark_oak_stairs[facing=south,half=bottom]
fill ~-17 ~6 ~38 ~-7 ~6 ~38 dark_oak_stairs[facing=north,half=bottom]
fill ~-17 ~6 ~29 ~-17 ~6 ~37 dark_oak_stairs[facing=east,half=bottom]
fill ~-7 ~6 ~29 ~-7 ~6 ~37 dark_oak_stairs[facing=west,half=bottom]

# Roof peak
fill ~-15 ~7 ~30 ~-9 ~7 ~36 dark_oak_planks
setblock ~-12 ~8 ~33 amethyst_block
setblock ~-12 ~9 ~33 amethyst_cluster[facing=up]

# Interior: bed, chest, crafting table, lantern
setblock ~-16 ~1 ~28 green_bed[facing=south,part=head]
setblock ~-16 ~1 ~29 green_bed[facing=south,part=foot]
setblock ~-8 ~1 ~28 chest[facing=south]
setblock ~-8 ~1 ~30 crafting_table
setblock ~-12 ~4 ~33 soul_lantern

# Floor (spruce planks inside)
fill ~-17 ~0 ~28 ~-7 ~0 ~38 spruce_planks

# Banner (green, beside door on south face)
setblock ~-11 ~3 ~39 green_wall_banner[facing=north]

# Name sign
setblock ~-13 ~3 ~39 spruce_wall_sign[facing=north]{front_text:{messages:['{"text":"Igor"}','{"text":""}','{"text":""}','{"text":""}']}}

# Soul lanterns at entrance
setblock ~-14 ~3 ~40 soul_lantern
setblock ~-10 ~3 ~40 soul_lantern
