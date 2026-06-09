# Plaza - 50 wide x 30 deep, for Jira bookshelf board
# Centered at ~0 ~-1 ~-5 (just north of atrium)

# Main floor (polished deepslate)
fill ~-25 ~-1 ~-20 ~25 ~-1 ~9 polished_deepslate

# Border trim (gilded blackstone)
fill ~-25 ~-1 ~-20 ~25 ~-1 ~-20 gilded_blackstone
fill ~-25 ~-1 ~9 ~25 ~-1 ~9 gilded_blackstone
fill ~-25 ~-1 ~-20 ~-25 ~-1 ~9 gilded_blackstone
fill ~25 ~-1 ~-20 ~25 ~-1 ~9 gilded_blackstone

# Inner accent border (polished blackstone)
fill ~-24 ~-1 ~-19 ~24 ~-1 ~-19 polished_blackstone
fill ~-24 ~-1 ~8 ~24 ~-1 ~8 polished_blackstone
fill ~-24 ~-1 ~-19 ~-24 ~-1 ~8 polished_blackstone
fill ~24 ~-1 ~-19 ~24 ~-1 ~8 polished_blackstone

# Low walls on north/east/west sides (polished deepslate, 2 high)
fill ~-25 ~0 ~-20 ~25 ~1 ~-20 polished_deepslate_slab
fill ~-25 ~0 ~-20 ~-25 ~1 ~9 polished_deepslate_slab
fill ~25 ~0 ~-20 ~25 ~1 ~9 polished_deepslate_slab

# Pillar accents at corners and midpoints
fill ~-25 ~0 ~-20 ~-25 ~2 ~-20 deepslate_bricks
fill ~25 ~0 ~-20 ~25 ~2 ~-20 deepslate_bricks
fill ~-25 ~0 ~9 ~-25 ~2 ~9 deepslate_bricks
fill ~25 ~0 ~9 ~25 ~2 ~9 deepslate_bricks
fill ~-12 ~0 ~-20 ~-12 ~2 ~-20 deepslate_bricks
fill ~12 ~0 ~-20 ~12 ~2 ~-20 deepslate_bricks
fill ~0 ~0 ~-20 ~0 ~2 ~-20 deepslate_bricks

# Lanterns on pillars
setblock ~-25 ~3 ~-20 soul_lantern
setblock ~25 ~3 ~-20 soul_lantern
setblock ~-25 ~3 ~9 soul_lantern
setblock ~25 ~3 ~9 soul_lantern
setblock ~-12 ~3 ~-20 soul_lantern
setblock ~12 ~3 ~-20 soul_lantern
setblock ~0 ~3 ~-20 soul_lantern

# Jira board area marker (row of bookshelves along north wall)
fill ~-20 ~0 ~-19 ~20 ~0 ~-19 bookshelf
fill ~-20 ~1 ~-19 ~20 ~1 ~-19 bookshelf

# Section divider signs (sprint columns)
setblock ~-15 ~2 ~-19 spruce_wall_sign[facing=south]{front_text:{messages:['{"text":"TO DO"}','{"text":""}','{"text":""}','{"text":""}']}}
setblock ~-5 ~2 ~-19 spruce_wall_sign[facing=south]{front_text:{messages:['{"text":"IN PROGRESS"}','{"text":""}','{"text":""}','{"text":""}']}}
setblock ~5 ~2 ~-19 spruce_wall_sign[facing=south]{front_text:{messages:['{"text":"REVIEW"}','{"text":""}','{"text":""}','{"text":""}']}}
setblock ~15 ~2 ~-19 spruce_wall_sign[facing=south]{front_text:{messages:['{"text":"DONE"}','{"text":""}','{"text":""}','{"text":""}']}}
