# GitHub Tower - All 5 pagoda tiers
# Center: ~32 ~0 ~-4

# ============================================
# TIER 1 - GROUND FLOOR (y=1 to y=7)
# Walls on 29x29 footprint: x=18-46, z=-18 to 10
# ============================================

# Corner posts (black concrete, 6 high)
fill ~18 ~1 ~-18 ~18 ~6 ~-18 black_concrete
fill ~46 ~1 ~-18 ~46 ~6 ~-18 black_concrete
fill ~18 ~1 ~10 ~18 ~6 ~10 black_concrete
fill ~46 ~1 ~10 ~46 ~6 ~10 black_concrete

# Mid-wall posts (every ~5 blocks)
# North wall (z=-18)
fill ~24 ~1 ~-18 ~24 ~6 ~-18 black_concrete
fill ~30 ~1 ~-18 ~30 ~6 ~-18 black_concrete
fill ~34 ~1 ~-18 ~34 ~6 ~-18 black_concrete
fill ~40 ~1 ~-18 ~40 ~6 ~-18 black_concrete
# South wall (z=10)
fill ~24 ~1 ~10 ~24 ~6 ~10 black_concrete
fill ~30 ~1 ~10 ~30 ~6 ~10 black_concrete
fill ~34 ~1 ~10 ~34 ~6 ~10 black_concrete
fill ~40 ~1 ~10 ~40 ~6 ~10 black_concrete
# West wall (x=18) - leave gap for entrance
fill ~18 ~1 ~-12 ~18 ~6 ~-12 black_concrete
fill ~18 ~1 ~4 ~18 ~6 ~4 black_concrete
# East wall (x=46)
fill ~46 ~1 ~-12 ~46 ~6 ~-12 black_concrete
fill ~46 ~1 ~-4 ~46 ~6 ~-4 black_concrete
fill ~46 ~1 ~4 ~46 ~6 ~4 black_concrete

# Top beam ring (y=6, gray concrete)
fill ~18 ~6 ~-18 ~46 ~6 ~-18 gray_concrete
fill ~18 ~6 ~10 ~46 ~6 ~10 gray_concrete
fill ~18 ~6 ~-18 ~18 ~6 ~10 gray_concrete
fill ~46 ~6 ~-18 ~46 ~6 ~10 gray_concrete

# Mid beam ring (y=3, gray concrete)
fill ~18 ~3 ~-18 ~46 ~3 ~-18 gray_concrete
fill ~18 ~3 ~10 ~46 ~3 ~10 gray_concrete
fill ~18 ~3 ~-18 ~18 ~3 ~10 gray_concrete
fill ~46 ~3 ~-18 ~46 ~3 ~10 gray_concrete

# Shoji panels - white concrete infill
# North wall y=1-2
fill ~19 ~1 ~-18 ~23 ~2 ~-18 white_concrete
fill ~25 ~1 ~-18 ~29 ~2 ~-18 white_concrete
fill ~31 ~1 ~-18 ~33 ~2 ~-18 white_concrete
fill ~35 ~1 ~-18 ~39 ~2 ~-18 white_concrete
fill ~41 ~1 ~-18 ~45 ~2 ~-18 white_concrete
# North wall y=4-5
fill ~19 ~4 ~-18 ~23 ~5 ~-18 white_concrete
fill ~25 ~4 ~-18 ~29 ~5 ~-18 white_concrete
fill ~31 ~4 ~-18 ~33 ~5 ~-18 white_concrete
fill ~35 ~4 ~-18 ~39 ~5 ~-18 white_concrete
fill ~41 ~4 ~-18 ~45 ~5 ~-18 white_concrete
# South wall y=1-2
fill ~19 ~1 ~10 ~23 ~2 ~10 white_concrete
fill ~25 ~1 ~10 ~29 ~2 ~10 white_concrete
fill ~31 ~1 ~10 ~33 ~2 ~10 white_concrete
fill ~35 ~1 ~10 ~39 ~2 ~10 white_concrete
fill ~41 ~1 ~10 ~45 ~2 ~10 white_concrete
# South wall y=4-5
fill ~19 ~4 ~10 ~23 ~5 ~10 white_concrete
fill ~25 ~4 ~10 ~29 ~5 ~10 white_concrete
fill ~31 ~4 ~10 ~33 ~5 ~10 white_concrete
fill ~35 ~4 ~10 ~39 ~5 ~10 white_concrete
fill ~41 ~4 ~10 ~45 ~5 ~10 white_concrete
# East wall (x=46) y=1-2
fill ~46 ~1 ~-17 ~46 ~2 ~-13 white_concrete
fill ~46 ~1 ~-11 ~46 ~2 ~-5 white_concrete
fill ~46 ~1 ~-3 ~46 ~2 ~3 white_concrete
fill ~46 ~1 ~5 ~46 ~2 ~9 white_concrete
# East wall y=4-5
fill ~46 ~4 ~-17 ~46 ~5 ~-13 white_concrete
fill ~46 ~4 ~-11 ~46 ~5 ~-5 white_concrete
fill ~46 ~4 ~-3 ~46 ~5 ~3 white_concrete
fill ~46 ~4 ~5 ~46 ~5 ~9 white_concrete
# West wall (x=18) - only sides, middle is entrance
fill ~18 ~1 ~-17 ~18 ~2 ~-13 white_concrete
fill ~18 ~1 ~5 ~18 ~2 ~9 white_concrete
fill ~18 ~4 ~-17 ~18 ~5 ~-13 white_concrete
fill ~18 ~4 ~5 ~18 ~5 ~9 white_concrete

# Interior air (clear inside)
fill ~19 ~1 ~-17 ~45 ~6 ~9 air

# Tier 1 roof (31x31 at y=7)
fill ~17 ~7 ~-19 ~47 ~7 ~11 polished_blackstone_slab
fill ~17 ~7 ~-19 ~47 ~7 ~-19 polished_blackstone_stairs[facing=south,half=bottom]
fill ~17 ~7 ~11 ~47 ~7 ~11 polished_blackstone_stairs[facing=north,half=bottom]
fill ~17 ~7 ~-18 ~17 ~7 ~10 polished_blackstone_stairs[facing=east,half=bottom]
fill ~47 ~7 ~-18 ~47 ~7 ~10 polished_blackstone_stairs[facing=west,half=bottom]
# Corner upswept
setblock ~17 ~8 ~-19 polished_blackstone_stairs[facing=south,half=bottom]
setblock ~47 ~8 ~-19 polished_blackstone_stairs[facing=south,half=bottom]
setblock ~17 ~8 ~11 polished_blackstone_stairs[facing=north,half=bottom]
setblock ~47 ~8 ~11 polished_blackstone_stairs[facing=north,half=bottom]

# Attic fill
fill ~19 ~8 ~-17 ~45 ~8 ~9 gray_concrete

# ============================================
# TIER 2 (y=9 to y=14) - 21x21
# x=22 to 42, z=-14 to 6
# ============================================

# Floor
fill ~22 ~9 ~-14 ~42 ~9 ~6 white_concrete

# Corner posts
fill ~22 ~10 ~-14 ~22 ~13 ~-14 black_concrete
fill ~42 ~10 ~-14 ~42 ~13 ~-14 black_concrete
fill ~22 ~10 ~6 ~22 ~13 ~6 black_concrete
fill ~42 ~10 ~6 ~42 ~13 ~6 black_concrete

# Mid-wall posts
fill ~32 ~10 ~-14 ~32 ~13 ~-14 black_concrete
fill ~32 ~10 ~6 ~32 ~13 ~6 black_concrete
fill ~22 ~10 ~-4 ~22 ~13 ~-4 black_concrete
fill ~42 ~10 ~-4 ~42 ~13 ~-4 black_concrete

# Top beam (y=13)
fill ~22 ~13 ~-14 ~42 ~13 ~-14 gray_concrete
fill ~22 ~13 ~6 ~42 ~13 ~6 gray_concrete
fill ~22 ~13 ~-14 ~22 ~13 ~6 gray_concrete
fill ~42 ~13 ~-14 ~42 ~13 ~6 gray_concrete

# White panels y=10-11
fill ~23 ~10 ~-14 ~31 ~11 ~-14 white_concrete
fill ~33 ~10 ~-14 ~41 ~11 ~-14 white_concrete
fill ~23 ~10 ~6 ~31 ~11 ~6 white_concrete
fill ~33 ~10 ~6 ~41 ~11 ~6 white_concrete
fill ~22 ~10 ~-13 ~22 ~11 ~-5 white_concrete
fill ~22 ~10 ~-3 ~22 ~11 ~5 white_concrete
fill ~42 ~10 ~-13 ~42 ~11 ~-5 white_concrete
fill ~42 ~10 ~-3 ~42 ~11 ~5 white_concrete

# Interior air
fill ~23 ~10 ~-13 ~41 ~13 ~5 air

# Tier 2 roof (23x23 at y=14)
fill ~21 ~14 ~-15 ~43 ~14 ~7 polished_blackstone_slab
fill ~21 ~14 ~-15 ~43 ~14 ~-15 polished_blackstone_stairs[facing=south,half=bottom]
fill ~21 ~14 ~7 ~43 ~14 ~7 polished_blackstone_stairs[facing=north,half=bottom]
fill ~21 ~14 ~-14 ~21 ~14 ~6 polished_blackstone_stairs[facing=east,half=bottom]
fill ~43 ~14 ~-14 ~43 ~14 ~6 polished_blackstone_stairs[facing=west,half=bottom]
setblock ~21 ~15 ~-15 polished_blackstone_stairs[facing=south,half=bottom]
setblock ~43 ~15 ~-15 polished_blackstone_stairs[facing=south,half=bottom]
setblock ~21 ~15 ~7 polished_blackstone_stairs[facing=north,half=bottom]
setblock ~43 ~15 ~7 polished_blackstone_stairs[facing=north,half=bottom]

# ============================================
# TIER 3 (y=15 to y=20) - 15x15
# x=25 to 39, z=-11 to 3
# ============================================

# Floor
fill ~25 ~15 ~-11 ~39 ~15 ~3 white_concrete

# Corner posts
fill ~25 ~16 ~-11 ~25 ~19 ~-11 black_concrete
fill ~39 ~16 ~-11 ~39 ~19 ~-11 black_concrete
fill ~25 ~16 ~3 ~25 ~19 ~3 black_concrete
fill ~39 ~16 ~3 ~39 ~19 ~3 black_concrete

# Mid-wall posts
fill ~32 ~16 ~-11 ~32 ~19 ~-11 black_concrete
fill ~32 ~16 ~3 ~32 ~19 ~3 black_concrete
fill ~25 ~16 ~-4 ~25 ~19 ~-4 black_concrete
fill ~39 ~16 ~-4 ~39 ~19 ~-4 black_concrete

# Top beam (y=19)
fill ~25 ~19 ~-11 ~39 ~19 ~-11 gray_concrete
fill ~25 ~19 ~3 ~39 ~19 ~3 gray_concrete
fill ~25 ~19 ~-11 ~25 ~19 ~3 gray_concrete
fill ~39 ~19 ~-11 ~39 ~19 ~3 gray_concrete

# White panels
fill ~26 ~16 ~-11 ~31 ~17 ~-11 white_concrete
fill ~33 ~16 ~-11 ~38 ~17 ~-11 white_concrete
fill ~26 ~16 ~3 ~31 ~17 ~3 white_concrete
fill ~33 ~16 ~3 ~38 ~17 ~3 white_concrete
fill ~25 ~16 ~-10 ~25 ~17 ~-5 white_concrete
fill ~25 ~16 ~-3 ~25 ~17 ~2 white_concrete
fill ~39 ~16 ~-10 ~39 ~17 ~-5 white_concrete
fill ~39 ~16 ~-3 ~39 ~17 ~2 white_concrete

# Interior air
fill ~26 ~16 ~-10 ~38 ~19 ~2 air

# Tier 3 roof (17x17 at y=20)
fill ~24 ~20 ~-12 ~40 ~20 ~4 polished_blackstone_slab
fill ~24 ~20 ~-12 ~40 ~20 ~-12 polished_blackstone_stairs[facing=south,half=bottom]
fill ~24 ~20 ~4 ~40 ~20 ~4 polished_blackstone_stairs[facing=north,half=bottom]
fill ~24 ~20 ~-11 ~24 ~20 ~3 polished_blackstone_stairs[facing=east,half=bottom]
fill ~40 ~20 ~-11 ~40 ~20 ~3 polished_blackstone_stairs[facing=west,half=bottom]
setblock ~24 ~21 ~-12 polished_blackstone_stairs[facing=south,half=bottom]
setblock ~40 ~21 ~-12 polished_blackstone_stairs[facing=south,half=bottom]
setblock ~24 ~21 ~4 polished_blackstone_stairs[facing=north,half=bottom]
setblock ~40 ~21 ~4 polished_blackstone_stairs[facing=north,half=bottom]

# ============================================
# TIER 4 (y=21 to y=26) - 9x9
# x=28 to 36, z=-8 to 0
# ============================================

# Floor
fill ~28 ~21 ~-8 ~36 ~21 ~0 white_concrete

# Corner posts
fill ~28 ~22 ~-8 ~28 ~25 ~-8 black_concrete
fill ~36 ~22 ~-8 ~36 ~25 ~-8 black_concrete
fill ~28 ~22 ~0 ~28 ~25 ~0 black_concrete
fill ~36 ~22 ~0 ~36 ~25 ~0 black_concrete

# Mid-wall posts
fill ~32 ~22 ~-8 ~32 ~25 ~-8 black_concrete
fill ~32 ~22 ~0 ~32 ~25 ~0 black_concrete
fill ~28 ~22 ~-4 ~28 ~25 ~-4 black_concrete
fill ~36 ~22 ~-4 ~36 ~25 ~-4 black_concrete

# Top beam (y=25)
fill ~28 ~25 ~-8 ~36 ~25 ~-8 gray_concrete
fill ~28 ~25 ~0 ~36 ~25 ~0 gray_concrete
fill ~28 ~25 ~-8 ~28 ~25 ~0 gray_concrete
fill ~36 ~25 ~-8 ~36 ~25 ~0 gray_concrete

# White panels
fill ~29 ~22 ~-8 ~31 ~23 ~-8 white_concrete
fill ~33 ~22 ~-8 ~35 ~23 ~-8 white_concrete
fill ~29 ~22 ~0 ~31 ~23 ~0 white_concrete
fill ~33 ~22 ~0 ~35 ~23 ~0 white_concrete
fill ~28 ~22 ~-7 ~28 ~23 ~-5 white_concrete
fill ~28 ~22 ~-3 ~28 ~23 ~-1 white_concrete
fill ~36 ~22 ~-7 ~36 ~23 ~-5 white_concrete
fill ~36 ~22 ~-3 ~36 ~23 ~-1 white_concrete

# Interior air
fill ~29 ~22 ~-7 ~35 ~25 ~-1 air

# Tier 4 roof (11x11 at y=26)
fill ~27 ~26 ~-9 ~37 ~26 ~1 polished_blackstone_slab
fill ~27 ~26 ~-9 ~37 ~26 ~-9 polished_blackstone_stairs[facing=south,half=bottom]
fill ~27 ~26 ~1 ~37 ~26 ~1 polished_blackstone_stairs[facing=north,half=bottom]
fill ~27 ~26 ~-8 ~27 ~26 ~0 polished_blackstone_stairs[facing=east,half=bottom]
fill ~37 ~26 ~-8 ~37 ~26 ~0 polished_blackstone_stairs[facing=west,half=bottom]
setblock ~27 ~27 ~-9 polished_blackstone_stairs[facing=south,half=bottom]
setblock ~37 ~27 ~-9 polished_blackstone_stairs[facing=south,half=bottom]
setblock ~27 ~27 ~1 polished_blackstone_stairs[facing=north,half=bottom]
setblock ~37 ~27 ~1 polished_blackstone_stairs[facing=north,half=bottom]

# ============================================
# TIER 5 - TOP (y=27 to y=32) - 5x5
# x=30 to 34, z=-6 to -2
# ============================================

# Floor
fill ~30 ~27 ~-6 ~34 ~27 ~-2 white_concrete

# Corner posts
fill ~30 ~28 ~-6 ~30 ~31 ~-6 black_concrete
fill ~34 ~28 ~-6 ~34 ~31 ~-6 black_concrete
fill ~30 ~28 ~-2 ~30 ~31 ~-2 black_concrete
fill ~34 ~28 ~-2 ~34 ~31 ~-2 black_concrete

# Top beam (y=31)
fill ~30 ~31 ~-6 ~34 ~31 ~-6 gray_concrete
fill ~30 ~31 ~-2 ~34 ~31 ~-2 gray_concrete
fill ~30 ~31 ~-6 ~30 ~31 ~-2 gray_concrete
fill ~34 ~31 ~-6 ~34 ~31 ~-2 gray_concrete

# Open railing
setblock ~32 ~28 ~-6 white_concrete
setblock ~32 ~28 ~-2 white_concrete
setblock ~30 ~28 ~-4 white_concrete
setblock ~34 ~28 ~-4 white_concrete

# Interior air
fill ~31 ~28 ~-5 ~33 ~31 ~-3 air

# Tier 5 roof (7x7 at y=32)
fill ~29 ~32 ~-7 ~35 ~32 ~-1 polished_blackstone_slab
fill ~29 ~32 ~-7 ~35 ~32 ~-7 polished_blackstone_stairs[facing=south,half=bottom]
fill ~29 ~32 ~-1 ~35 ~32 ~-1 polished_blackstone_stairs[facing=north,half=bottom]
fill ~29 ~32 ~-6 ~29 ~32 ~-2 polished_blackstone_stairs[facing=east,half=bottom]
fill ~35 ~32 ~-6 ~35 ~32 ~-2 polished_blackstone_stairs[facing=west,half=bottom]
setblock ~29 ~33 ~-7 polished_blackstone_stairs[facing=south,half=bottom]
setblock ~35 ~33 ~-7 polished_blackstone_stairs[facing=south,half=bottom]
setblock ~29 ~33 ~-1 polished_blackstone_stairs[facing=north,half=bottom]
setblock ~35 ~33 ~-1 polished_blackstone_stairs[facing=north,half=bottom]

# ============================================
# FINIAL
# ============================================
setblock ~32 ~33 ~-4 gold_block
setblock ~32 ~34 ~-4 lightning_rod

# ============================================
# SOUL LANTERNS (one per tier)
# ============================================
setblock ~32 ~6 ~-4 soul_lantern
setblock ~32 ~13 ~-4 soul_lantern
setblock ~32 ~19 ~-4 soul_lantern
setblock ~32 ~25 ~-4 soul_lantern
setblock ~32 ~31 ~-4 soul_lantern
