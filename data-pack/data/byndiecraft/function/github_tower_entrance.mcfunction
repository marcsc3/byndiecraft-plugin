# GitHub Tower - Grand Open Entrance
# West face (x=18), centered on z=-4, 7 wide x 6 tall
# NO DOOR - fully open walkthrough

# ============================================
# OPEN ARCHWAY (7 wide x 6 tall)
# ============================================

# Clear entrance area (z=-7 to z=-1, y=1 to y=6)
fill ~18 ~1 ~-7 ~18 ~6 ~-1 air

# Arch frame pillars
fill ~18 ~1 ~-8 ~18 ~6 ~-8 black_concrete
fill ~18 ~1 ~0 ~18 ~6 ~0 black_concrete

# Top arch beam
fill ~18 ~6 ~-7 ~18 ~6 ~-1 black_concrete

# Arch curve detail (polished blackstone stairs)
setblock ~18 ~6 ~-7 polished_blackstone_stairs[facing=north,half=bottom]
setblock ~18 ~6 ~-1 polished_blackstone_stairs[facing=south,half=bottom]
setblock ~18 ~5 ~-7 polished_blackstone_stairs[facing=north,half=top]
setblock ~18 ~5 ~-1 polished_blackstone_stairs[facing=south,half=top]

# ============================================
# WIDE STAIRCASE (7 blocks wide, 2 steps)
# ============================================

fill ~16 ~0 ~-7 ~16 ~0 ~-1 polished_blackstone_stairs[facing=east,half=bottom]
fill ~17 ~0 ~-7 ~17 ~0 ~-1 polished_blackstone_stairs[facing=east,half=bottom]

# ============================================
# FLANKING PILLARS (3 blocks out from wall)
# ============================================

# Left pillar (7 blocks tall)
fill ~15 ~0 ~-9 ~15 ~6 ~-9 gray_concrete
setblock ~15 ~7 ~-9 polished_blackstone_slab
setblock ~15 ~8 ~-9 soul_lantern

# Right pillar (7 blocks tall)
fill ~15 ~0 ~1 ~15 ~6 ~1 gray_concrete
setblock ~15 ~7 ~1 polished_blackstone_slab
setblock ~15 ~8 ~1 soul_lantern

# ============================================
# TORII GATE (GitHub colors, scaled up)
# ============================================

# Left pillar
fill ~13 ~0 ~-9 ~13 ~6 ~-9 gray_concrete
# Right pillar
fill ~13 ~0 ~1 ~13 ~6 ~1 gray_concrete
# Top crossbeam (kasagi)
fill ~13 ~7 ~-10 ~13 ~7 ~2 black_concrete
# Secondary beam (nuki)
fill ~13 ~6 ~-9 ~13 ~6 ~1 gray_concrete
# Top slab overhang
fill ~13 ~8 ~-10 ~13 ~8 ~2 polished_blackstone_slab

# ============================================
# STONE LANTERNS (beside staircase)
# ============================================

setblock ~15 ~0 ~-7 stone_brick_wall
setblock ~15 ~1 ~-7 smooth_stone_slab[type=double]
setblock ~15 ~2 ~-7 lantern

setblock ~15 ~0 ~-1 stone_brick_wall
setblock ~15 ~1 ~-1 smooth_stone_slab[type=double]
setblock ~15 ~2 ~-1 lantern

# ============================================
# SIGNS & BANNERS
# ============================================

# Name sign
setblock ~18 ~4 ~-8 bamboo_wall_sign[facing=west]{front_text:{messages:['{"text":"GitHub"}','{"text":"Tower"}','{"text":""}','{"text":""}']}}

# Black banners flanking arch
setblock ~18 ~5 ~-8 black_wall_banner[facing=west]
setblock ~18 ~5 ~0 black_wall_banner[facing=west]
