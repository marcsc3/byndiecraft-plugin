# House 2 - Marc's house
# Position: ~-20 ~0 ~50, door faces EAST (toward courtyard)
# Banner: Cyan

# Foundation (13x13 polished deepslate)
fill ~-26 ~-1 ~44 ~-14 ~-1 ~56 polished_deepslate
fill ~-26 ~0 ~44 ~-14 ~0 ~56 polished_deepslate

# Walls (spruce planks, 4 high)
fill ~-26 ~1 ~44 ~-14 ~4 ~44 spruce_planks
fill ~-26 ~1 ~56 ~-14 ~4 ~56 spruce_planks
fill ~-26 ~1 ~44 ~-26 ~4 ~56 spruce_planks
fill ~-14 ~1 ~44 ~-14 ~4 ~56 spruce_planks

# Interior air
fill ~-25 ~1 ~45 ~-15 ~4 ~55 air

# Door (east-facing, center of east wall)
setblock ~-14 ~1 ~50 spruce_door[facing=west,half=lower,hinge=left]
setblock ~-14 ~2 ~50 spruce_door[facing=west,half=upper,hinge=left]

# Windows (spruce fence)
setblock ~-14 ~2 ~47 spruce_fence
setblock ~-14 ~3 ~47 spruce_fence
setblock ~-14 ~2 ~53 spruce_fence
setblock ~-14 ~3 ~53 spruce_fence
setblock ~-26 ~2 ~50 spruce_fence
setblock ~-26 ~3 ~50 spruce_fence
setblock ~-20 ~2 ~44 spruce_fence
setblock ~-20 ~3 ~44 spruce_fence
setblock ~-20 ~2 ~56 spruce_fence
setblock ~-20 ~3 ~56 spruce_fence

# Roof - tier 1 (dark oak stairs, overhanging by 1)
fill ~-27 ~5 ~43 ~-13 ~5 ~57 dark_oak_slab
fill ~-27 ~5 ~43 ~-13 ~5 ~43 dark_oak_stairs[facing=south,half=bottom]
fill ~-27 ~5 ~57 ~-13 ~5 ~57 dark_oak_stairs[facing=north,half=bottom]
fill ~-27 ~5 ~44 ~-27 ~5 ~56 dark_oak_stairs[facing=east,half=bottom]
fill ~-13 ~5 ~44 ~-13 ~5 ~56 dark_oak_stairs[facing=west,half=bottom]

# Roof - tier 2 (narrower)
fill ~-25 ~6 ~45 ~-15 ~6 ~55 dark_oak_slab
fill ~-25 ~6 ~45 ~-15 ~6 ~45 dark_oak_stairs[facing=south,half=bottom]
fill ~-25 ~6 ~55 ~-15 ~6 ~55 dark_oak_stairs[facing=north,half=bottom]
fill ~-25 ~6 ~46 ~-25 ~6 ~54 dark_oak_stairs[facing=east,half=bottom]
fill ~-15 ~6 ~46 ~-15 ~6 ~54 dark_oak_stairs[facing=west,half=bottom]

# Roof peak
fill ~-23 ~7 ~47 ~-17 ~7 ~53 dark_oak_planks
setblock ~-20 ~8 ~50 amethyst_block
setblock ~-20 ~9 ~50 amethyst_cluster[facing=up]

# Interior: bed, chest, crafting table, lantern
setblock ~-24 ~1 ~54 cyan_bed[facing=north,part=head]
setblock ~-24 ~1 ~55 cyan_bed[facing=north,part=foot]
setblock ~-24 ~1 ~45 chest[facing=east]
setblock ~-22 ~1 ~45 crafting_table
setblock ~-20 ~4 ~50 soul_lantern

# Floor (spruce planks inside)
fill ~-25 ~0 ~45 ~-15 ~0 ~55 spruce_planks

# Banner (cyan, beside door on east face)
setblock ~-14 ~3 ~51 cyan_wall_banner[facing=west]

# Name sign
setblock ~-14 ~3 ~49 spruce_wall_sign[facing=west]{front_text:{messages:['{"text":"Marc"}','{"text":""}','{"text":""}','{"text":""}']}}

# Soul lanterns at entrance
setblock ~-13 ~3 ~48 soul_lantern
setblock ~-13 ~3 ~52 soul_lantern
