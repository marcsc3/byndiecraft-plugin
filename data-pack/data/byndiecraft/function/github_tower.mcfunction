# GitHub Temple Tower
# Position: center ~30 ~0 ~-20, door faces WEST (toward plaza center)
# 13x13 base, 5-tier pagoda, ~32 blocks tall
# Colors: GitHub brand (black, white, gray)

# ============================================
# FOUNDATION & PLATFORM
# ============================================

# Foundation (15x15 polished deepslate)
fill ~23 ~-1 ~-27 ~37 ~-1 ~-13 polished_deepslate

# Platform floor (13x13 white concrete)
fill ~24 ~0 ~-26 ~36 ~0 ~-14 white_concrete

# Floor border (13x13 gray concrete frame)
fill ~24 ~0 ~-26 ~36 ~0 ~-26 gray_concrete
fill ~24 ~0 ~-14 ~36 ~0 ~-14 gray_concrete
fill ~24 ~0 ~-26 ~24 ~0 ~-14 gray_concrete
fill ~36 ~0 ~-26 ~36 ~0 ~-14 gray_concrete

# ============================================
# OCTOCAT FLOOR LOGO (11x11 at y=0)
# ============================================
# Grid origin: ~25 ~0 ~-25 (col 0, row 0)
# Row 0: ears tips
setblock ~28 ~0 ~-25 black_concrete
setblock ~32 ~0 ~-25 black_concrete
# Row 1: ear bases
fill ~27 ~0 ~-24 ~29 ~0 ~-24 black_concrete
fill ~31 ~0 ~-24 ~33 ~0 ~-24 black_concrete
# Row 2: full head width
fill ~26 ~0 ~-23 ~34 ~0 ~-23 black_concrete
# Row 3: head with eyes (gaps at col 3 and 7)
fill ~26 ~0 ~-22 ~27 ~0 ~-22 black_concrete
fill ~29 ~0 ~-22 ~31 ~0 ~-22 black_concrete
fill ~33 ~0 ~-22 ~34 ~0 ~-22 black_concrete
# Row 4: full body width
fill ~26 ~0 ~-21 ~34 ~0 ~-21 black_concrete
# Row 5: body narrower
fill ~27 ~0 ~-20 ~33 ~0 ~-20 black_concrete
# Row 6: body narrower
fill ~27 ~0 ~-19 ~33 ~0 ~-19 black_concrete
# Row 7: tentacles start (cols 1,2, 4, 6, 8,9)
setblock ~26 ~0 ~-18 black_concrete
setblock ~27 ~0 ~-18 black_concrete
setblock ~29 ~0 ~-18 black_concrete
setblock ~31 ~0 ~-18 black_concrete
setblock ~33 ~0 ~-18 black_concrete
setblock ~34 ~0 ~-18 black_concrete
# Row 8: tentacles mid (cols 1, 4, 6, 9)
setblock ~26 ~0 ~-17 black_concrete
setblock ~29 ~0 ~-17 black_concrete
setblock ~31 ~0 ~-17 black_concrete
setblock ~34 ~0 ~-17 black_concrete
# Row 9: tentacles mid (cols 1, 4, 6, 9)
setblock ~26 ~0 ~-16 black_concrete
setblock ~29 ~0 ~-16 black_concrete
setblock ~31 ~0 ~-16 black_concrete
setblock ~34 ~0 ~-16 black_concrete
# Row 10: tentacles tips (cols 4, 6)
setblock ~29 ~0 ~-15 black_concrete
setblock ~31 ~0 ~-15 black_concrete

# ============================================
# TIER 1 - GROUND FLOOR (y=1 to y=5)
# ============================================

# Corner posts (black concrete, 4 high)
fill ~25 ~1 ~-25 ~25 ~4 ~-25 black_concrete
fill ~35 ~1 ~-25 ~35 ~4 ~-25 black_concrete
fill ~25 ~1 ~-15 ~25 ~4 ~-15 black_concrete
fill ~35 ~1 ~-15 ~35 ~4 ~-15 black_concrete

# Mid-wall posts
# North wall (z=-25)
fill ~28 ~1 ~-25 ~28 ~4 ~-25 black_concrete
fill ~32 ~1 ~-25 ~32 ~4 ~-25 black_concrete
# South wall (z=-15)
fill ~28 ~1 ~-15 ~28 ~4 ~-15 black_concrete
fill ~32 ~1 ~-15 ~32 ~4 ~-15 black_concrete
# West wall (x=25)
fill ~25 ~1 ~-22 ~25 ~4 ~-22 black_concrete
fill ~25 ~1 ~-18 ~25 ~4 ~-18 black_concrete
# East wall (x=35)
fill ~35 ~1 ~-22 ~35 ~4 ~-22 black_concrete
fill ~35 ~1 ~-18 ~35 ~4 ~-18 black_concrete

# Top beam ring (y=4, gray concrete)
fill ~25 ~4 ~-25 ~35 ~4 ~-25 gray_concrete
fill ~25 ~4 ~-15 ~35 ~4 ~-15 gray_concrete
fill ~25 ~4 ~-25 ~25 ~4 ~-15 gray_concrete
fill ~35 ~4 ~-25 ~35 ~4 ~-15 gray_concrete

# Mid beam ring (y=2, gray concrete)
fill ~25 ~2 ~-25 ~35 ~2 ~-25 gray_concrete
fill ~25 ~2 ~-15 ~35 ~2 ~-15 gray_concrete
fill ~25 ~2 ~-25 ~25 ~2 ~-15 gray_concrete
fill ~35 ~2 ~-25 ~35 ~2 ~-15 gray_concrete

# Shoji panels - white concrete infill
# North wall (z=-25) y=1
fill ~26 ~1 ~-25 ~27 ~1 ~-25 white_concrete
fill ~29 ~1 ~-25 ~31 ~1 ~-25 white_concrete
fill ~33 ~1 ~-25 ~34 ~1 ~-25 white_concrete
# North wall y=3
fill ~26 ~3 ~-25 ~27 ~3 ~-25 white_concrete
fill ~29 ~3 ~-25 ~31 ~3 ~-25 white_concrete
fill ~33 ~3 ~-25 ~34 ~3 ~-25 white_concrete
# South wall (z=-15) y=1
fill ~26 ~1 ~-15 ~27 ~1 ~-15 white_concrete
fill ~29 ~1 ~-15 ~31 ~1 ~-15 white_concrete
fill ~33 ~1 ~-15 ~34 ~1 ~-15 white_concrete
# South wall y=3
fill ~26 ~3 ~-15 ~27 ~3 ~-15 white_concrete
fill ~29 ~3 ~-15 ~31 ~3 ~-15 white_concrete
fill ~33 ~3 ~-15 ~34 ~3 ~-15 white_concrete
# West wall (x=25) y=1
fill ~25 ~1 ~-24 ~25 ~1 ~-23 white_concrete
fill ~25 ~1 ~-21 ~25 ~1 ~-19 white_concrete
fill ~25 ~1 ~-17 ~25 ~1 ~-16 white_concrete
# West wall y=3
fill ~25 ~3 ~-24 ~25 ~3 ~-23 white_concrete
fill ~25 ~3 ~-21 ~25 ~3 ~-19 white_concrete
fill ~25 ~3 ~-17 ~25 ~3 ~-16 white_concrete
# East wall (x=35) y=1
fill ~35 ~1 ~-24 ~35 ~1 ~-23 white_concrete
fill ~35 ~1 ~-21 ~35 ~1 ~-19 white_concrete
fill ~35 ~1 ~-17 ~35 ~1 ~-16 white_concrete
# East wall y=3
fill ~35 ~3 ~-24 ~35 ~3 ~-23 white_concrete
fill ~35 ~3 ~-21 ~35 ~3 ~-19 white_concrete
fill ~35 ~3 ~-17 ~35 ~3 ~-16 white_concrete

# Interior air (clear inside)
fill ~26 ~1 ~-24 ~34 ~4 ~-16 air

# Tier 1 roof (15x15 at y=5)
fill ~23 ~5 ~-27 ~37 ~5 ~-13 polished_blackstone_slab
# Eave stairs
fill ~23 ~5 ~-27 ~37 ~5 ~-27 polished_blackstone_stairs[facing=south,half=bottom]
fill ~23 ~5 ~-13 ~37 ~5 ~-13 polished_blackstone_stairs[facing=north,half=bottom]
fill ~23 ~5 ~-26 ~23 ~5 ~-14 polished_blackstone_stairs[facing=east,half=bottom]
fill ~37 ~5 ~-26 ~37 ~5 ~-14 polished_blackstone_stairs[facing=west,half=bottom]
# Corner upswept tips
setblock ~23 ~6 ~-27 polished_blackstone_stairs[facing=south,half=bottom]
setblock ~37 ~6 ~-27 polished_blackstone_stairs[facing=south,half=bottom]
setblock ~23 ~6 ~-13 polished_blackstone_stairs[facing=north,half=bottom]
setblock ~37 ~6 ~-13 polished_blackstone_stairs[facing=north,half=bottom]

# Attic fill between tier 1 and 2
fill ~26 ~6 ~-24 ~34 ~6 ~-16 gray_concrete

# ============================================
# TIER 2 (y=7 to y=12)
# ============================================

# Floor
fill ~25 ~7 ~-25 ~35 ~7 ~-15 white_concrete

# Corner posts (black concrete, 4 high)
fill ~26 ~8 ~-24 ~26 ~11 ~-24 black_concrete
fill ~34 ~8 ~-24 ~34 ~11 ~-24 black_concrete
fill ~26 ~8 ~-16 ~26 ~11 ~-16 black_concrete
fill ~34 ~8 ~-16 ~34 ~11 ~-16 black_concrete

# Mid-wall posts
fill ~30 ~8 ~-24 ~30 ~11 ~-24 black_concrete
fill ~30 ~8 ~-16 ~30 ~11 ~-16 black_concrete
fill ~26 ~8 ~-20 ~26 ~11 ~-20 black_concrete
fill ~34 ~8 ~-20 ~34 ~11 ~-20 black_concrete

# Top beam (y=11)
fill ~26 ~11 ~-24 ~34 ~11 ~-24 gray_concrete
fill ~26 ~11 ~-16 ~34 ~11 ~-16 gray_concrete
fill ~26 ~11 ~-24 ~26 ~11 ~-16 gray_concrete
fill ~34 ~11 ~-24 ~34 ~11 ~-16 gray_concrete

# White panels y=8 and y=10
fill ~27 ~8 ~-24 ~29 ~8 ~-24 white_concrete
fill ~31 ~8 ~-24 ~33 ~8 ~-24 white_concrete
fill ~27 ~10 ~-24 ~29 ~10 ~-24 white_concrete
fill ~31 ~10 ~-24 ~33 ~10 ~-24 white_concrete
fill ~27 ~8 ~-16 ~29 ~8 ~-16 white_concrete
fill ~31 ~8 ~-16 ~33 ~8 ~-16 white_concrete
fill ~27 ~10 ~-16 ~29 ~10 ~-16 white_concrete
fill ~31 ~10 ~-16 ~33 ~10 ~-16 white_concrete
fill ~26 ~8 ~-23 ~26 ~8 ~-21 white_concrete
fill ~26 ~8 ~-19 ~26 ~8 ~-17 white_concrete
fill ~26 ~10 ~-23 ~26 ~10 ~-21 white_concrete
fill ~26 ~10 ~-19 ~26 ~10 ~-17 white_concrete
fill ~34 ~8 ~-23 ~34 ~8 ~-21 white_concrete
fill ~34 ~8 ~-19 ~34 ~8 ~-17 white_concrete
fill ~34 ~10 ~-23 ~34 ~10 ~-21 white_concrete
fill ~34 ~10 ~-19 ~34 ~10 ~-17 white_concrete

# Interior air
fill ~27 ~8 ~-23 ~33 ~11 ~-17 air

# Tier 2 roof (13x13 at y=12)
fill ~24 ~12 ~-26 ~36 ~12 ~-14 polished_blackstone_slab
fill ~24 ~12 ~-26 ~36 ~12 ~-26 polished_blackstone_stairs[facing=south,half=bottom]
fill ~24 ~12 ~-14 ~36 ~12 ~-14 polished_blackstone_stairs[facing=north,half=bottom]
fill ~24 ~12 ~-25 ~24 ~12 ~-15 polished_blackstone_stairs[facing=east,half=bottom]
fill ~36 ~12 ~-25 ~36 ~12 ~-15 polished_blackstone_stairs[facing=west,half=bottom]
# Corner upswept
setblock ~24 ~13 ~-26 polished_blackstone_stairs[facing=south,half=bottom]
setblock ~36 ~13 ~-26 polished_blackstone_stairs[facing=south,half=bottom]
setblock ~24 ~13 ~-14 polished_blackstone_stairs[facing=north,half=bottom]
setblock ~36 ~13 ~-14 polished_blackstone_stairs[facing=north,half=bottom]

# ============================================
# TIER 3 (y=13 to y=18)
# ============================================

# Floor
fill ~27 ~13 ~-23 ~33 ~13 ~-17 white_concrete

# Corner posts
fill ~27 ~14 ~-23 ~27 ~17 ~-23 black_concrete
fill ~33 ~14 ~-23 ~33 ~17 ~-23 black_concrete
fill ~27 ~14 ~-17 ~27 ~17 ~-17 black_concrete
fill ~33 ~14 ~-17 ~33 ~17 ~-17 black_concrete

# Mid-wall posts
fill ~30 ~14 ~-23 ~30 ~17 ~-23 black_concrete
fill ~30 ~14 ~-17 ~30 ~17 ~-17 black_concrete
fill ~27 ~14 ~-20 ~27 ~17 ~-20 black_concrete
fill ~33 ~14 ~-20 ~33 ~17 ~-20 black_concrete

# Top beam (y=17)
fill ~27 ~17 ~-23 ~33 ~17 ~-23 gray_concrete
fill ~27 ~17 ~-17 ~33 ~17 ~-17 gray_concrete
fill ~27 ~17 ~-23 ~27 ~17 ~-17 gray_concrete
fill ~33 ~17 ~-23 ~33 ~17 ~-17 gray_concrete

# White panels y=14 and y=16
fill ~28 ~14 ~-23 ~29 ~14 ~-23 white_concrete
fill ~31 ~14 ~-23 ~32 ~14 ~-23 white_concrete
fill ~28 ~16 ~-23 ~29 ~16 ~-23 white_concrete
fill ~31 ~16 ~-23 ~32 ~16 ~-23 white_concrete
fill ~28 ~14 ~-17 ~29 ~14 ~-17 white_concrete
fill ~31 ~14 ~-17 ~32 ~14 ~-17 white_concrete
fill ~28 ~16 ~-17 ~29 ~16 ~-17 white_concrete
fill ~31 ~16 ~-17 ~32 ~16 ~-17 white_concrete
fill ~27 ~14 ~-22 ~27 ~14 ~-21 white_concrete
fill ~27 ~14 ~-19 ~27 ~14 ~-18 white_concrete
fill ~27 ~16 ~-22 ~27 ~16 ~-21 white_concrete
fill ~27 ~16 ~-19 ~27 ~16 ~-18 white_concrete
fill ~33 ~14 ~-22 ~33 ~14 ~-21 white_concrete
fill ~33 ~14 ~-19 ~33 ~14 ~-18 white_concrete
fill ~33 ~16 ~-22 ~33 ~16 ~-21 white_concrete
fill ~33 ~16 ~-19 ~33 ~16 ~-18 white_concrete

# Interior air
fill ~28 ~14 ~-22 ~32 ~17 ~-18 air

# Tier 3 roof (11x11 at y=18)
fill ~25 ~18 ~-25 ~35 ~18 ~-15 polished_blackstone_slab
fill ~25 ~18 ~-25 ~35 ~18 ~-25 polished_blackstone_stairs[facing=south,half=bottom]
fill ~25 ~18 ~-15 ~35 ~18 ~-15 polished_blackstone_stairs[facing=north,half=bottom]
fill ~25 ~18 ~-24 ~25 ~18 ~-16 polished_blackstone_stairs[facing=east,half=bottom]
fill ~35 ~18 ~-24 ~35 ~18 ~-16 polished_blackstone_stairs[facing=west,half=bottom]
# Corner upswept
setblock ~25 ~19 ~-25 polished_blackstone_stairs[facing=south,half=bottom]
setblock ~35 ~19 ~-25 polished_blackstone_stairs[facing=south,half=bottom]
setblock ~25 ~19 ~-15 polished_blackstone_stairs[facing=north,half=bottom]
setblock ~35 ~19 ~-15 polished_blackstone_stairs[facing=north,half=bottom]

# ============================================
# TIER 4 (y=19 to y=24)
# ============================================

# Floor
fill ~28 ~19 ~-22 ~32 ~19 ~-18 white_concrete

# Corner posts
fill ~28 ~20 ~-22 ~28 ~23 ~-22 black_concrete
fill ~32 ~20 ~-22 ~32 ~23 ~-22 black_concrete
fill ~28 ~20 ~-18 ~28 ~23 ~-18 black_concrete
fill ~32 ~20 ~-18 ~32 ~23 ~-18 black_concrete

# Mid-wall posts
fill ~30 ~20 ~-22 ~30 ~23 ~-22 black_concrete
fill ~30 ~20 ~-18 ~30 ~23 ~-18 black_concrete
fill ~28 ~20 ~-20 ~28 ~23 ~-20 black_concrete
fill ~32 ~20 ~-20 ~32 ~23 ~-20 black_concrete

# Top beam (y=23)
fill ~28 ~23 ~-22 ~32 ~23 ~-22 gray_concrete
fill ~28 ~23 ~-18 ~32 ~23 ~-18 gray_concrete
fill ~28 ~23 ~-22 ~28 ~23 ~-18 gray_concrete
fill ~32 ~23 ~-22 ~32 ~23 ~-18 gray_concrete

# White panels y=20 and y=22
fill ~29 ~20 ~-22 ~29 ~20 ~-22 white_concrete
fill ~31 ~20 ~-22 ~31 ~20 ~-22 white_concrete
fill ~29 ~22 ~-22 ~29 ~22 ~-22 white_concrete
fill ~31 ~22 ~-22 ~31 ~22 ~-22 white_concrete
fill ~29 ~20 ~-18 ~29 ~20 ~-18 white_concrete
fill ~31 ~20 ~-18 ~31 ~20 ~-18 white_concrete
fill ~29 ~22 ~-18 ~29 ~22 ~-18 white_concrete
fill ~31 ~22 ~-18 ~31 ~22 ~-18 white_concrete
fill ~28 ~20 ~-21 ~28 ~20 ~-21 white_concrete
fill ~28 ~20 ~-19 ~28 ~20 ~-19 white_concrete
fill ~28 ~22 ~-21 ~28 ~22 ~-21 white_concrete
fill ~28 ~22 ~-19 ~28 ~22 ~-19 white_concrete
fill ~32 ~20 ~-21 ~32 ~20 ~-21 white_concrete
fill ~32 ~20 ~-19 ~32 ~20 ~-19 white_concrete
fill ~32 ~22 ~-21 ~32 ~22 ~-21 white_concrete
fill ~32 ~22 ~-19 ~32 ~22 ~-19 white_concrete

# Interior air
fill ~29 ~20 ~-21 ~31 ~23 ~-19 air

# Tier 4 roof (9x9 at y=24)
fill ~26 ~24 ~-24 ~34 ~24 ~-16 polished_blackstone_slab
fill ~26 ~24 ~-24 ~34 ~24 ~-24 polished_blackstone_stairs[facing=south,half=bottom]
fill ~26 ~24 ~-16 ~34 ~24 ~-16 polished_blackstone_stairs[facing=north,half=bottom]
fill ~26 ~24 ~-23 ~26 ~24 ~-17 polished_blackstone_stairs[facing=east,half=bottom]
fill ~34 ~24 ~-23 ~34 ~24 ~-17 polished_blackstone_stairs[facing=west,half=bottom]
# Corner upswept
setblock ~26 ~25 ~-24 polished_blackstone_stairs[facing=south,half=bottom]
setblock ~34 ~25 ~-24 polished_blackstone_stairs[facing=south,half=bottom]
setblock ~26 ~25 ~-16 polished_blackstone_stairs[facing=north,half=bottom]
setblock ~34 ~25 ~-16 polished_blackstone_stairs[facing=north,half=bottom]

# ============================================
# TIER 5 - TOP FLOOR (y=25 to y=29)
# ============================================

# Floor
fill ~29 ~25 ~-21 ~31 ~25 ~-19 white_concrete

# Corner posts
fill ~29 ~26 ~-21 ~29 ~28 ~-21 black_concrete
fill ~31 ~26 ~-21 ~31 ~28 ~-21 black_concrete
fill ~29 ~26 ~-19 ~29 ~28 ~-19 black_concrete
fill ~31 ~26 ~-19 ~31 ~28 ~-19 black_concrete

# Top beam (y=28)
fill ~29 ~28 ~-21 ~31 ~28 ~-21 gray_concrete
fill ~29 ~28 ~-19 ~31 ~28 ~-19 gray_concrete
fill ~29 ~28 ~-21 ~29 ~28 ~-19 gray_concrete
fill ~31 ~28 ~-21 ~31 ~28 ~-19 gray_concrete

# Open railing (white concrete walls for observation)
setblock ~30 ~26 ~-21 white_concrete
setblock ~30 ~26 ~-19 white_concrete
setblock ~29 ~26 ~-20 white_concrete
setblock ~31 ~26 ~-20 white_concrete

# Interior air
fill ~30 ~26 ~-20 ~30 ~28 ~-20 air

# Tier 5 roof (7x7 at y=29)
fill ~27 ~29 ~-23 ~33 ~29 ~-17 polished_blackstone_slab
fill ~27 ~29 ~-23 ~33 ~29 ~-23 polished_blackstone_stairs[facing=south,half=bottom]
fill ~27 ~29 ~-17 ~33 ~29 ~-17 polished_blackstone_stairs[facing=north,half=bottom]
fill ~27 ~29 ~-22 ~27 ~29 ~-18 polished_blackstone_stairs[facing=east,half=bottom]
fill ~33 ~29 ~-22 ~33 ~29 ~-18 polished_blackstone_stairs[facing=west,half=bottom]
# Corner upswept
setblock ~27 ~30 ~-23 polished_blackstone_stairs[facing=south,half=bottom]
setblock ~33 ~30 ~-23 polished_blackstone_stairs[facing=south,half=bottom]
setblock ~27 ~30 ~-17 polished_blackstone_stairs[facing=north,half=bottom]
setblock ~33 ~30 ~-17 polished_blackstone_stairs[facing=north,half=bottom]

# ============================================
# FINIAL
# ============================================
setblock ~30 ~30 ~-20 gold_block
setblock ~30 ~31 ~-20 lightning_rod

# ============================================
# ENTRANCE (West side, facing plaza)
# ============================================

# Entrance opening (clear wall for door)
setblock ~25 ~1 ~-21 air
setblock ~25 ~2 ~-21 air
setblock ~25 ~1 ~-20 air
setblock ~25 ~2 ~-20 air
setblock ~25 ~1 ~-19 air
setblock ~25 ~2 ~-19 air

# Entrance stairs (west side)
setblock ~24 ~0 ~-21 polished_blackstone_stairs[facing=east,half=bottom]
setblock ~24 ~0 ~-20 polished_blackstone_stairs[facing=east,half=bottom]
setblock ~24 ~0 ~-19 polished_blackstone_stairs[facing=east,half=bottom]

# Door (bamboo, west-facing)
setblock ~25 ~1 ~-20 bamboo_door[facing=west,half=lower,hinge=left]
setblock ~25 ~2 ~-20 bamboo_door[facing=west,half=upper,hinge=left]

# Mini torii gate (GitHub colors - gray pillars, black beam)
fill ~22 ~0 ~-22 ~22 ~4 ~-22 gray_concrete
fill ~22 ~0 ~-18 ~22 ~4 ~-18 gray_concrete
fill ~22 ~5 ~-22 ~22 ~5 ~-18 black_concrete
fill ~22 ~6 ~-23 ~22 ~6 ~-17 polished_blackstone_slab

# Stone lanterns flanking entrance
setblock ~24 ~0 ~-23 stone_brick_wall
setblock ~24 ~1 ~-23 smooth_stone_slab[type=double]
setblock ~24 ~2 ~-23 lantern
setblock ~24 ~0 ~-17 stone_brick_wall
setblock ~24 ~1 ~-17 smooth_stone_slab[type=double]
setblock ~24 ~2 ~-17 lantern

# ============================================
# INTERIOR FURNISHINGS
# ============================================

# Ground floor: enchanting table + bookshelves
setblock ~30 ~1 ~-20 enchanting_table
setblock ~31 ~1 ~-22 bookshelf
setblock ~32 ~1 ~-22 bookshelf
setblock ~33 ~1 ~-22 bookshelf
setblock ~34 ~1 ~-21 bookshelf
setblock ~34 ~1 ~-20 bookshelf
setblock ~34 ~1 ~-19 bookshelf

# Soul lanterns (one per tier ceiling)
setblock ~30 ~4 ~-20 soul_lantern
setblock ~30 ~11 ~-20 soul_lantern
setblock ~30 ~17 ~-20 soul_lantern
setblock ~30 ~23 ~-20 soul_lantern
setblock ~30 ~28 ~-20 soul_lantern

# ============================================
# NAME SIGN & BANNER
# ============================================

# Name sign
setblock ~25 ~3 ~-19 bamboo_wall_sign[facing=west]{front_text:{messages:['{"text":"GitHub"}','{"text":"Tower"}','{"text":""}','{"text":""}']}}

# Black banner beside door
setblock ~25 ~3 ~-21 black_wall_banner[facing=west]
