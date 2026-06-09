# Plaza - 80 wide x 80 deep, for Jira bookshelf board
# Centered at ~0 ~-1 ~-5 (just north of atrium)

# Main floor (polished deepslate)
fill ~-40 ~-1 ~-45 ~40 ~-1 ~34 polished_deepslate

# Border trim (gilded blackstone)
fill ~-40 ~-1 ~-45 ~40 ~-1 ~-45 gilded_blackstone
fill ~-40 ~-1 ~34 ~40 ~-1 ~34 gilded_blackstone
fill ~-40 ~-1 ~-45 ~-40 ~-1 ~34 gilded_blackstone
fill ~40 ~-1 ~-45 ~40 ~-1 ~34 gilded_blackstone

# Inner accent border (polished blackstone)
fill ~-39 ~-1 ~-44 ~39 ~-1 ~-44 polished_blackstone
fill ~-39 ~-1 ~33 ~39 ~-1 ~33 polished_blackstone
fill ~-39 ~-1 ~-44 ~-39 ~-1 ~33 polished_blackstone
fill ~39 ~-1 ~-44 ~39 ~-1 ~33 polished_blackstone

# Low walls on north/east/west sides (polished deepslate, 2 high)
fill ~-40 ~0 ~-45 ~40 ~1 ~-45 polished_deepslate_slab
fill ~-40 ~0 ~-45 ~-40 ~1 ~34 polished_deepslate_slab
fill ~40 ~0 ~-45 ~40 ~1 ~34 polished_deepslate_slab

# Pillar accents at corners and midpoints
fill ~-40 ~0 ~-45 ~-40 ~2 ~-45 deepslate_bricks
fill ~40 ~0 ~-45 ~40 ~2 ~-45 deepslate_bricks
fill ~-40 ~0 ~34 ~-40 ~2 ~34 deepslate_bricks
fill ~40 ~0 ~34 ~40 ~2 ~34 deepslate_bricks
fill ~-20 ~0 ~-45 ~-20 ~2 ~-45 deepslate_bricks
fill ~20 ~0 ~-45 ~20 ~2 ~-45 deepslate_bricks
fill ~0 ~0 ~-45 ~0 ~2 ~-45 deepslate_bricks

# Lanterns on pillars
setblock ~-40 ~3 ~-45 soul_lantern
setblock ~40 ~3 ~-45 soul_lantern
setblock ~-40 ~3 ~34 soul_lantern
setblock ~40 ~3 ~34 soul_lantern
setblock ~-20 ~3 ~-45 soul_lantern
setblock ~20 ~3 ~-45 soul_lantern
setblock ~0 ~3 ~-45 soul_lantern

# Jira board area marker (row of bookshelves along north wall)
fill ~-20 ~0 ~-44 ~20 ~0 ~-44 bookshelf
fill ~-20 ~1 ~-44 ~20 ~1 ~-44 bookshelf

# Section divider signs (sprint columns)
setblock ~-15 ~2 ~-44 spruce_wall_sign[facing=south]{front_text:{messages:['{"text":"TO DO"}','{"text":""}','{"text":""}','{"text":""}']}}
setblock ~-5 ~2 ~-44 spruce_wall_sign[facing=south]{front_text:{messages:['{"text":"IN PROGRESS"}','{"text":""}','{"text":""}','{"text":""}']}}
setblock ~5 ~2 ~-44 spruce_wall_sign[facing=south]{front_text:{messages:['{"text":"REVIEW"}','{"text":""}','{"text":""}','{"text":""}']}}
setblock ~15 ~2 ~-44 spruce_wall_sign[facing=south]{front_text:{messages:['{"text":"DONE"}','{"text":""}','{"text":""}','{"text":""}']}}
