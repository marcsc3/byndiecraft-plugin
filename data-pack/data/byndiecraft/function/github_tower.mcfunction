# GitHub Temple Tower - Structure
# Position: center ~30 ~0 ~-10, entrance faces WEST (toward plaza center)
# 19x19 base, 5-tier pagoda, ~34 blocks tall
# Colors: GitHub brand (black, white, gray)

# ============================================
# FOUNDATION & PLATFORM
# ============================================

# Foundation (21x21 polished deepslate)
fill ~19 ~-1 ~-21 ~41 ~-1 ~1 polished_deepslate

# Platform floor (19x19 white concrete)
fill ~21 ~0 ~-19 ~39 ~0 ~-1 white_concrete

# Floor border (19x19 gray concrete frame)
fill ~21 ~0 ~-19 ~39 ~0 ~-19 gray_concrete
fill ~21 ~0 ~-1 ~39 ~0 ~-1 gray_concrete
fill ~21 ~0 ~-19 ~21 ~0 ~-1 gray_concrete
fill ~39 ~0 ~-19 ~39 ~0 ~-1 gray_concrete

# ============================================
# OCTOCAT FLOOR LOGO (15x15 at y=0)
# ============================================
# Grid origin: ~23 ~0 ~-17 (col 0 = x+23, row 0 = z-17)
# B = black_concrete, . = white_concrete (already placed as platform)

# Row 0: cols 5-9
fill ~28 ~0 ~-17 ~32 ~0 ~-17 black_concrete
# Row 1: cols 3-11
fill ~26 ~0 ~-16 ~34 ~0 ~-16 black_concrete
# Row 2: cols 2-12
fill ~25 ~0 ~-15 ~35 ~0 ~-15 black_concrete
# Row 3: cols 1-3, 5-9, 11-13
fill ~24 ~0 ~-14 ~26 ~0 ~-14 black_concrete
fill ~28 ~0 ~-14 ~32 ~0 ~-14 black_concrete
fill ~34 ~0 ~-14 ~36 ~0 ~-14 black_concrete
# Row 4: cols 1-2, 5-9, 12-13
fill ~24 ~0 ~-13 ~25 ~0 ~-13 black_concrete
fill ~28 ~0 ~-13 ~32 ~0 ~-13 black_concrete
fill ~35 ~0 ~-13 ~36 ~0 ~-13 black_concrete
# Row 5: cols 0-2, 6-8, 12-14
fill ~23 ~0 ~-12 ~25 ~0 ~-12 black_concrete
fill ~29 ~0 ~-12 ~31 ~0 ~-12 black_concrete
fill ~35 ~0 ~-12 ~37 ~0 ~-12 black_concrete
# Row 6: cols 0-2, 7, 12-14
fill ~23 ~0 ~-11 ~25 ~0 ~-11 black_concrete
setblock ~30 ~0 ~-11 black_concrete
fill ~35 ~0 ~-11 ~37 ~0 ~-11 black_concrete
# Row 7: cols 0-2, 7, 12-14
fill ~23 ~0 ~-10 ~25 ~0 ~-10 black_concrete
setblock ~30 ~0 ~-10 black_concrete
fill ~35 ~0 ~-10 ~37 ~0 ~-10 black_concrete
# Row 8: cols 0-2, 6-8, 12-14
fill ~23 ~0 ~-9 ~25 ~0 ~-9 black_concrete
fill ~29 ~0 ~-9 ~31 ~0 ~-9 black_concrete
fill ~35 ~0 ~-9 ~37 ~0 ~-9 black_concrete
# Row 9: cols 0-2, 5-6, 8-9, 12-14
fill ~23 ~0 ~-8 ~25 ~0 ~-8 black_concrete
fill ~28 ~0 ~-8 ~29 ~0 ~-8 black_concrete
fill ~31 ~0 ~-8 ~32 ~0 ~-8 black_concrete
fill ~35 ~0 ~-8 ~37 ~0 ~-8 black_concrete
# Row 10: cols 1-2, 4-5, 9-10, 12-13
fill ~24 ~0 ~-7 ~25 ~0 ~-7 black_concrete
fill ~27 ~0 ~-7 ~28 ~0 ~-7 black_concrete
fill ~32 ~0 ~-7 ~33 ~0 ~-7 black_concrete
fill ~35 ~0 ~-7 ~36 ~0 ~-7 black_concrete
# Row 11: cols 1-4, 10-13
fill ~24 ~0 ~-6 ~27 ~0 ~-6 black_concrete
fill ~33 ~0 ~-6 ~36 ~0 ~-6 black_concrete
# Row 12: cols 2-5, 9-12
fill ~25 ~0 ~-5 ~28 ~0 ~-5 black_concrete
fill ~32 ~0 ~-5 ~35 ~0 ~-5 black_concrete
# Row 13: cols 3-11
fill ~26 ~0 ~-4 ~34 ~0 ~-4 black_concrete
# Row 14: cols 5-9
fill ~28 ~0 ~-3 ~32 ~0 ~-3 black_concrete

# ============================================
# TIER 1 - GROUND FLOOR (y=1 to y=6)
# ============================================

# Corner posts (black concrete, 5 high)
fill ~22 ~1 ~-18 ~22 ~5 ~-18 black_concrete
fill ~38 ~1 ~-18 ~38 ~5 ~-18 black_concrete
fill ~22 ~1 ~-2 ~22 ~5 ~-2 black_concrete
fill ~38 ~1 ~-2 ~38 ~5 ~-2 black_concrete

# Mid-wall posts (every 4 blocks)
# North wall (z=-18)
fill ~26 ~1 ~-18 ~26 ~5 ~-18 black_concrete
fill ~30 ~1 ~-18 ~30 ~5 ~-18 black_concrete
fill ~34 ~1 ~-18 ~34 ~5 ~-18 black_concrete
# South wall (z=-2)
fill ~26 ~1 ~-2 ~26 ~5 ~-2 black_concrete
fill ~30 ~1 ~-2 ~30 ~5 ~-2 black_concrete
fill ~34 ~1 ~-2 ~34 ~5 ~-2 black_concrete
# West wall (x=22)
fill ~22 ~1 ~-14 ~22 ~5 ~-14 black_concrete
fill ~22 ~1 ~-10 ~22 ~5 ~-10 black_concrete
fill ~22 ~1 ~-6 ~22 ~5 ~-6 black_concrete
# East wall (x=38)
fill ~38 ~1 ~-14 ~38 ~5 ~-14 black_concrete
fill ~38 ~1 ~-10 ~38 ~5 ~-10 black_concrete
fill ~38 ~1 ~-6 ~38 ~5 ~-6 black_concrete

# Top beam ring (y=5, gray concrete)
fill ~22 ~5 ~-18 ~38 ~5 ~-18 gray_concrete
fill ~22 ~5 ~-2 ~38 ~5 ~-2 gray_concrete
fill ~22 ~5 ~-18 ~22 ~5 ~-2 gray_concrete
fill ~38 ~5 ~-18 ~38 ~5 ~-2 gray_concrete

# Mid beam ring (y=3, gray concrete)
fill ~22 ~3 ~-18 ~38 ~3 ~-18 gray_concrete
fill ~22 ~3 ~-2 ~38 ~3 ~-2 gray_concrete
fill ~22 ~3 ~-18 ~22 ~3 ~-2 gray_concrete
fill ~38 ~3 ~-18 ~38 ~3 ~-2 gray_concrete

# Shoji panels - white concrete infill y=1,2 and y=4
# North wall (z=-18)
fill ~23 ~1 ~-18 ~25 ~2 ~-18 white_concrete
fill ~27 ~1 ~-18 ~29 ~2 ~-18 white_concrete
fill ~31 ~1 ~-18 ~33 ~2 ~-18 white_concrete
fill ~35 ~1 ~-18 ~37 ~2 ~-18 white_concrete
fill ~23 ~4 ~-18 ~25 ~4 ~-18 white_concrete
fill ~27 ~4 ~-18 ~29 ~4 ~-18 white_concrete
fill ~31 ~4 ~-18 ~33 ~4 ~-18 white_concrete
fill ~35 ~4 ~-18 ~37 ~4 ~-18 white_concrete
# South wall (z=-2)
fill ~23 ~1 ~-2 ~25 ~2 ~-2 white_concrete
fill ~27 ~1 ~-2 ~29 ~2 ~-2 white_concrete
fill ~31 ~1 ~-2 ~33 ~2 ~-2 white_concrete
fill ~35 ~1 ~-2 ~37 ~2 ~-2 white_concrete
fill ~23 ~4 ~-2 ~25 ~4 ~-2 white_concrete
fill ~27 ~4 ~-2 ~29 ~4 ~-2 white_concrete
fill ~31 ~4 ~-2 ~33 ~4 ~-2 white_concrete
fill ~35 ~4 ~-2 ~37 ~4 ~-2 white_concrete
# East wall (x=38)
fill ~38 ~1 ~-17 ~38 ~2 ~-15 white_concrete
fill ~38 ~1 ~-13 ~38 ~2 ~-11 white_concrete
fill ~38 ~1 ~-9 ~38 ~2 ~-7 white_concrete
fill ~38 ~1 ~-5 ~38 ~2 ~-3 white_concrete
fill ~38 ~4 ~-17 ~38 ~4 ~-15 white_concrete
fill ~38 ~4 ~-13 ~38 ~4 ~-11 white_concrete
fill ~38 ~4 ~-9 ~38 ~4 ~-7 white_concrete
fill ~38 ~4 ~-5 ~38 ~4 ~-3 white_concrete
# West wall (x=22) - partial, entrance gap in middle
fill ~22 ~1 ~-17 ~22 ~2 ~-15 white_concrete
fill ~22 ~1 ~-5 ~22 ~2 ~-3 white_concrete
fill ~22 ~4 ~-17 ~22 ~4 ~-15 white_concrete
fill ~22 ~4 ~-5 ~22 ~4 ~-3 white_concrete

# Interior air (clear inside)
fill ~23 ~1 ~-17 ~37 ~5 ~-3 air

# Tier 1 roof (21x21 at y=6)
fill ~19 ~6 ~-21 ~41 ~6 ~1 polished_blackstone_slab
# Eave stairs
fill ~19 ~6 ~-21 ~41 ~6 ~-21 polished_blackstone_stairs[facing=south,half=bottom]
fill ~19 ~6 ~1 ~41 ~6 ~1 polished_blackstone_stairs[facing=north,half=bottom]
fill ~19 ~6 ~-20 ~19 ~6 ~0 polished_blackstone_stairs[facing=east,half=bottom]
fill ~41 ~6 ~-20 ~41 ~6 ~0 polished_blackstone_stairs[facing=west,half=bottom]
# Corner upswept tips
setblock ~19 ~7 ~-21 polished_blackstone_stairs[facing=south,half=bottom]
setblock ~41 ~7 ~-21 polished_blackstone_stairs[facing=south,half=bottom]
setblock ~19 ~7 ~1 polished_blackstone_stairs[facing=north,half=bottom]
setblock ~41 ~7 ~1 polished_blackstone_stairs[facing=north,half=bottom]

# Attic fill between tier 1 and 2
fill ~23 ~7 ~-17 ~37 ~7 ~-3 gray_concrete

# ============================================
# TIER 2 (y=8 to y=13)
# ============================================

# Floor (15x15)
fill ~23 ~8 ~-17 ~37 ~8 ~-3 white_concrete

# Corner posts
fill ~24 ~9 ~-16 ~24 ~12 ~-16 black_concrete
fill ~36 ~9 ~-16 ~36 ~12 ~-16 black_concrete
fill ~24 ~9 ~-4 ~24 ~12 ~-4 black_concrete
fill ~36 ~9 ~-4 ~36 ~12 ~-4 black_concrete

# Mid-wall posts
fill ~30 ~9 ~-16 ~30 ~12 ~-16 black_concrete
fill ~30 ~9 ~-4 ~30 ~12 ~-4 black_concrete
fill ~24 ~9 ~-10 ~24 ~12 ~-10 black_concrete
fill ~36 ~9 ~-10 ~36 ~12 ~-10 black_concrete

# Top beam (y=12)
fill ~24 ~12 ~-16 ~36 ~12 ~-16 gray_concrete
fill ~24 ~12 ~-4 ~36 ~12 ~-4 gray_concrete
fill ~24 ~12 ~-16 ~24 ~12 ~-4 gray_concrete
fill ~36 ~12 ~-16 ~36 ~12 ~-4 gray_concrete

# White panels y=9-10
fill ~25 ~9 ~-16 ~29 ~10 ~-16 white_concrete
fill ~31 ~9 ~-16 ~35 ~10 ~-16 white_concrete
fill ~25 ~9 ~-4 ~29 ~10 ~-4 white_concrete
fill ~31 ~9 ~-4 ~35 ~10 ~-4 white_concrete
fill ~24 ~9 ~-15 ~24 ~10 ~-11 white_concrete
fill ~24 ~9 ~-9 ~24 ~10 ~-5 white_concrete
fill ~36 ~9 ~-15 ~36 ~10 ~-11 white_concrete
fill ~36 ~9 ~-9 ~36 ~10 ~-5 white_concrete

# Interior air
fill ~25 ~9 ~-15 ~35 ~12 ~-5 air

# Tier 2 roof (17x17 at y=13)
fill ~22 ~13 ~-19 ~38 ~13 ~-1 polished_blackstone_slab
fill ~22 ~13 ~-19 ~38 ~13 ~-19 polished_blackstone_stairs[facing=south,half=bottom]
fill ~22 ~13 ~-1 ~38 ~13 ~-1 polished_blackstone_stairs[facing=north,half=bottom]
fill ~22 ~13 ~-18 ~22 ~13 ~-2 polished_blackstone_stairs[facing=east,half=bottom]
fill ~38 ~13 ~-18 ~38 ~13 ~-2 polished_blackstone_stairs[facing=west,half=bottom]
# Corner upswept
setblock ~22 ~14 ~-19 polished_blackstone_stairs[facing=south,half=bottom]
setblock ~38 ~14 ~-19 polished_blackstone_stairs[facing=south,half=bottom]
setblock ~22 ~14 ~-1 polished_blackstone_stairs[facing=north,half=bottom]
setblock ~38 ~14 ~-1 polished_blackstone_stairs[facing=north,half=bottom]

# ============================================
# TIER 3 (y=14 to y=19)
# ============================================

# Floor (11x11)
fill ~25 ~14 ~-15 ~35 ~14 ~-5 white_concrete

# Corner posts
fill ~26 ~15 ~-14 ~26 ~18 ~-14 black_concrete
fill ~34 ~15 ~-14 ~34 ~18 ~-14 black_concrete
fill ~26 ~15 ~-6 ~26 ~18 ~-6 black_concrete
fill ~34 ~15 ~-6 ~34 ~18 ~-6 black_concrete

# Mid-wall posts
fill ~30 ~15 ~-14 ~30 ~18 ~-14 black_concrete
fill ~30 ~15 ~-6 ~30 ~18 ~-6 black_concrete
fill ~26 ~15 ~-10 ~26 ~18 ~-10 black_concrete
fill ~34 ~15 ~-10 ~34 ~18 ~-10 black_concrete

# Top beam (y=18)
fill ~26 ~18 ~-14 ~34 ~18 ~-14 gray_concrete
fill ~26 ~18 ~-6 ~34 ~18 ~-6 gray_concrete
fill ~26 ~18 ~-14 ~26 ~18 ~-6 gray_concrete
fill ~34 ~18 ~-14 ~34 ~18 ~-6 gray_concrete

# White panels
fill ~27 ~15 ~-14 ~29 ~16 ~-14 white_concrete
fill ~31 ~15 ~-14 ~33 ~16 ~-14 white_concrete
fill ~27 ~15 ~-6 ~29 ~16 ~-6 white_concrete
fill ~31 ~15 ~-6 ~33 ~16 ~-6 white_concrete
fill ~26 ~15 ~-13 ~26 ~16 ~-11 white_concrete
fill ~26 ~15 ~-9 ~26 ~16 ~-7 white_concrete
fill ~34 ~15 ~-13 ~34 ~16 ~-11 white_concrete
fill ~34 ~15 ~-9 ~34 ~16 ~-7 white_concrete

# Interior air
fill ~27 ~15 ~-13 ~33 ~18 ~-7 air

# Tier 3 roof (13x13 at y=19)
fill ~24 ~19 ~-16 ~36 ~19 ~-4 polished_blackstone_slab
fill ~24 ~19 ~-16 ~36 ~19 ~-16 polished_blackstone_stairs[facing=south,half=bottom]
fill ~24 ~19 ~-4 ~36 ~19 ~-4 polished_blackstone_stairs[facing=north,half=bottom]
fill ~24 ~19 ~-15 ~24 ~19 ~-5 polished_blackstone_stairs[facing=east,half=bottom]
fill ~36 ~19 ~-15 ~36 ~19 ~-5 polished_blackstone_stairs[facing=west,half=bottom]
# Corner upswept
setblock ~24 ~20 ~-16 polished_blackstone_stairs[facing=south,half=bottom]
setblock ~36 ~20 ~-16 polished_blackstone_stairs[facing=south,half=bottom]
setblock ~24 ~20 ~-4 polished_blackstone_stairs[facing=north,half=bottom]
setblock ~36 ~20 ~-4 polished_blackstone_stairs[facing=north,half=bottom]

# ============================================
# TIER 4 (y=20 to y=25)
# ============================================

# Floor (7x7)
fill ~27 ~20 ~-13 ~33 ~20 ~-7 white_concrete

# Corner posts
fill ~28 ~21 ~-12 ~28 ~24 ~-12 black_concrete
fill ~32 ~21 ~-12 ~32 ~24 ~-12 black_concrete
fill ~28 ~21 ~-8 ~28 ~24 ~-8 black_concrete
fill ~32 ~21 ~-8 ~32 ~24 ~-8 black_concrete

# Mid-wall posts
fill ~30 ~21 ~-12 ~30 ~24 ~-12 black_concrete
fill ~30 ~21 ~-8 ~30 ~24 ~-8 black_concrete
fill ~28 ~21 ~-10 ~28 ~24 ~-10 black_concrete
fill ~32 ~21 ~-10 ~32 ~24 ~-10 black_concrete

# Top beam (y=24)
fill ~28 ~24 ~-12 ~32 ~24 ~-12 gray_concrete
fill ~28 ~24 ~-8 ~32 ~24 ~-8 gray_concrete
fill ~28 ~24 ~-12 ~28 ~24 ~-8 gray_concrete
fill ~32 ~24 ~-12 ~32 ~24 ~-8 gray_concrete

# White panels
setblock ~29 ~21 ~-12 white_concrete
setblock ~31 ~21 ~-12 white_concrete
setblock ~29 ~21 ~-8 white_concrete
setblock ~31 ~21 ~-8 white_concrete
setblock ~28 ~21 ~-11 white_concrete
setblock ~28 ~21 ~-9 white_concrete
setblock ~32 ~21 ~-11 white_concrete
setblock ~32 ~21 ~-9 white_concrete

# Interior air
fill ~29 ~21 ~-11 ~31 ~24 ~-9 air

# Tier 4 roof (9x9 at y=25)
fill ~26 ~25 ~-14 ~34 ~25 ~-6 polished_blackstone_slab
fill ~26 ~25 ~-14 ~34 ~25 ~-14 polished_blackstone_stairs[facing=south,half=bottom]
fill ~26 ~25 ~-6 ~34 ~25 ~-6 polished_blackstone_stairs[facing=north,half=bottom]
fill ~26 ~25 ~-13 ~26 ~25 ~-7 polished_blackstone_stairs[facing=east,half=bottom]
fill ~34 ~25 ~-13 ~34 ~25 ~-7 polished_blackstone_stairs[facing=west,half=bottom]
# Corner upswept
setblock ~26 ~26 ~-14 polished_blackstone_stairs[facing=south,half=bottom]
setblock ~34 ~26 ~-14 polished_blackstone_stairs[facing=south,half=bottom]
setblock ~26 ~26 ~-6 polished_blackstone_stairs[facing=north,half=bottom]
setblock ~34 ~26 ~-6 polished_blackstone_stairs[facing=north,half=bottom]

# ============================================
# TIER 5 - TOP FLOOR (y=26 to y=31)
# ============================================

# Floor (5x5)
fill ~28 ~26 ~-12 ~32 ~26 ~-8 white_concrete

# Corner posts
fill ~29 ~27 ~-11 ~29 ~30 ~-11 black_concrete
fill ~31 ~27 ~-11 ~31 ~30 ~-11 black_concrete
fill ~29 ~27 ~-9 ~29 ~30 ~-9 black_concrete
fill ~31 ~27 ~-9 ~31 ~30 ~-9 black_concrete

# Top beam (y=30)
fill ~29 ~30 ~-11 ~31 ~30 ~-11 gray_concrete
fill ~29 ~30 ~-9 ~31 ~30 ~-9 gray_concrete
fill ~29 ~30 ~-11 ~29 ~30 ~-9 gray_concrete
fill ~31 ~30 ~-11 ~31 ~30 ~-9 gray_concrete

# Open railing
setblock ~30 ~27 ~-11 white_concrete
setblock ~30 ~27 ~-9 white_concrete
setblock ~29 ~27 ~-10 white_concrete
setblock ~31 ~27 ~-10 white_concrete

# Interior air
fill ~30 ~27 ~-10 ~30 ~30 ~-10 air

# Tier 5 roof (7x7 at y=31)
fill ~27 ~31 ~-13 ~33 ~31 ~-7 polished_blackstone_slab
fill ~27 ~31 ~-13 ~33 ~31 ~-13 polished_blackstone_stairs[facing=south,half=bottom]
fill ~27 ~31 ~-7 ~33 ~31 ~-7 polished_blackstone_stairs[facing=north,half=bottom]
fill ~27 ~31 ~-12 ~27 ~31 ~-8 polished_blackstone_stairs[facing=east,half=bottom]
fill ~33 ~31 ~-12 ~33 ~31 ~-8 polished_blackstone_stairs[facing=west,half=bottom]
# Corner upswept
setblock ~27 ~32 ~-13 polished_blackstone_stairs[facing=south,half=bottom]
setblock ~33 ~32 ~-13 polished_blackstone_stairs[facing=south,half=bottom]
setblock ~27 ~32 ~-7 polished_blackstone_stairs[facing=north,half=bottom]
setblock ~33 ~32 ~-7 polished_blackstone_stairs[facing=north,half=bottom]

# ============================================
# FINIAL
# ============================================
setblock ~30 ~32 ~-10 gold_block
setblock ~30 ~33 ~-10 lightning_rod

# ============================================
# INTERIOR FURNISHINGS
# ============================================

# Ground floor: enchanting table + bookshelves
setblock ~30 ~1 ~-10 enchanting_table
setblock ~36 ~1 ~-17 bookshelf
setblock ~37 ~1 ~-17 bookshelf
setblock ~36 ~1 ~-16 bookshelf
setblock ~37 ~1 ~-16 bookshelf
setblock ~37 ~1 ~-15 bookshelf
setblock ~37 ~1 ~-14 bookshelf
setblock ~37 ~1 ~-13 bookshelf
setblock ~36 ~2 ~-17 bookshelf
setblock ~37 ~2 ~-17 bookshelf

# Soul lanterns (one per tier ceiling)
setblock ~30 ~5 ~-10 soul_lantern
setblock ~30 ~12 ~-10 soul_lantern
setblock ~30 ~18 ~-10 soul_lantern
setblock ~30 ~24 ~-10 soul_lantern
setblock ~30 ~30 ~-10 soul_lantern
