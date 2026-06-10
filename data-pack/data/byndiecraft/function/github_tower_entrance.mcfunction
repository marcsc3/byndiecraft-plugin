# GitHub Temple Tower - Grand Entrance
# West face (x=22), centered on z=-10
# Wide open archway, flanking pillars, torii gate

# ============================================
# GRAND ARCHWAY (5 wide x 5 tall, no door)
# ============================================

# Clear the entrance opening (west wall, z=-12 to z=-8, y=1 to y=5)
fill ~22 ~1 ~-12 ~22 ~5 ~-8 air

# Arch frame - black concrete surround
# Left pillar of arch
fill ~22 ~1 ~-13 ~22 ~5 ~-13 black_concrete
# Right pillar of arch
fill ~22 ~1 ~-7 ~22 ~5 ~-7 black_concrete
# Top beam of arch
fill ~22 ~5 ~-12 ~22 ~5 ~-8 black_concrete
# Arch detail - polished blackstone stairs curving inward at top
setblock ~22 ~5 ~-12 polished_blackstone_stairs[facing=north,half=bottom]
setblock ~22 ~5 ~-8 polished_blackstone_stairs[facing=south,half=bottom]
setblock ~22 ~4 ~-12 polished_blackstone_stairs[facing=north,half=top]
setblock ~22 ~4 ~-8 polished_blackstone_stairs[facing=south,half=top]

# ============================================
# FLANKING PILLARS (2 blocks out from wall)
# ============================================

# Left pillar (6 blocks tall)
fill ~20 ~0 ~-14 ~20 ~5 ~-14 gray_concrete
setblock ~20 ~6 ~-14 polished_blackstone_slab
setblock ~20 ~7 ~-14 soul_lantern

# Right pillar (6 blocks tall)
fill ~20 ~0 ~-6 ~20 ~5 ~-6 gray_concrete
setblock ~20 ~6 ~-6 polished_blackstone_slab
setblock ~20 ~7 ~-6 soul_lantern

# Pillar caps (decorative slab on top)
setblock ~20 ~6 ~-14 polished_blackstone_slab
setblock ~20 ~6 ~-6 polished_blackstone_slab

# ============================================
# ENTRANCE STAIRCASE (5 wide, 2 steps)
# ============================================

# Step 1 (further out)
fill ~20 ~0 ~-12 ~20 ~0 ~-8 polished_blackstone_stairs[facing=east,half=bottom]

# Step 2 (closer to entrance)
fill ~21 ~0 ~-12 ~21 ~0 ~-8 polished_blackstone_stairs[facing=east,half=bottom]

# ============================================
# TORII GATE (GitHub colors)
# ============================================

# Left pillar
fill ~18 ~0 ~-14 ~18 ~5 ~-14 gray_concrete
# Right pillar
fill ~18 ~0 ~-6 ~18 ~5 ~-6 gray_concrete
# Top crossbeam (kasagi)
fill ~18 ~6 ~-15 ~18 ~6 ~-5 black_concrete
# Secondary beam (nuki)
fill ~18 ~5 ~-14 ~18 ~5 ~-6 gray_concrete
# Top slab overhang
fill ~18 ~7 ~-15 ~18 ~7 ~-5 polished_blackstone_slab

# ============================================
# STONE LANTERNS
# ============================================

# Left lantern (beside staircase)
setblock ~19 ~0 ~-14 stone_brick_wall
setblock ~19 ~1 ~-14 smooth_stone_slab[type=double]
setblock ~19 ~2 ~-14 lantern

# Right lantern
setblock ~19 ~0 ~-6 stone_brick_wall
setblock ~19 ~1 ~-6 smooth_stone_slab[type=double]
setblock ~19 ~2 ~-6 lantern

# ============================================
# NAME SIGN & BANNER
# ============================================

# Name sign on arch
setblock ~22 ~3 ~-13 bamboo_wall_sign[facing=west]{front_text:{messages:['{"text":"GitHub"}','{"text":"Tower"}','{"text":""}','{"text":""}']}}

# Black banners flanking the archway
setblock ~22 ~4 ~-13 black_wall_banner[facing=west]
setblock ~22 ~4 ~-7 black_wall_banner[facing=west]
