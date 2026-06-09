# Paths - main road, bridge, and village connections
# Grand main road: 5 wide, z=74 to z=119 (from neighborhood to gatehouse)
# Japanese arched bridge: z=93-103 over 20-wide lake
# Village paths connecting all houses to courtyard

# ============================================
# GRAND MAIN ROAD (z=74 to z=119)
# 5 wide with dark oak plank borders
# ============================================

# Road surface (polished andesite, 5 wide)
fill ~-2 ~-1 ~74 ~2 ~-1 ~119 polished_andesite

# Dark oak borders
fill ~-3 ~-1 ~74 ~-3 ~-1 ~119 dark_oak_planks
fill ~3 ~-1 ~74 ~3 ~-1 ~119 dark_oak_planks

# Road lanterns (soul lanterns on spruce fence posts, every 8 blocks)
fill ~-4 ~0 ~76 ~-4 ~1 ~76 spruce_fence
setblock ~-4 ~2 ~76 soul_lantern
fill ~4 ~0 ~76 ~4 ~1 ~76 spruce_fence
setblock ~4 ~2 ~76 soul_lantern

fill ~-4 ~0 ~84 ~-4 ~1 ~84 spruce_fence
setblock ~-4 ~2 ~84 soul_lantern
fill ~4 ~0 ~84 ~4 ~1 ~84 spruce_fence
setblock ~4 ~2 ~84 soul_lantern

fill ~-4 ~0 ~108 ~-4 ~1 ~108 spruce_fence
setblock ~-4 ~2 ~108 soul_lantern
fill ~4 ~0 ~108 ~4 ~1 ~108 spruce_fence
setblock ~4 ~2 ~108 soul_lantern

fill ~-4 ~0 ~116 ~-4 ~1 ~116 spruce_fence
setblock ~-4 ~2 ~116 soul_lantern
fill ~4 ~0 ~116 ~4 ~1 ~116 spruce_fence
setblock ~4 ~2 ~116 soul_lantern

# ============================================
# LAKE (z=88 to z=108, 20 wide centered on road)
# ============================================

# Dig lake basin
fill ~-12 ~-2 ~88 ~12 ~-2 ~108 dirt
fill ~-10 ~-1 ~90 ~10 ~-1 ~106 water
fill ~-8 ~-1 ~88 ~8 ~-1 ~108 water

# Lily pads
setblock ~-6 ~0 ~92 lily_pad
setblock ~-8 ~0 ~96 lily_pad
setblock ~7 ~0 ~94 lily_pad
setblock ~9 ~0 ~100 lily_pad
setblock ~-5 ~0 ~104 lily_pad
setblock ~6 ~0 ~102 lily_pad

# Lake border (mossy stone)
fill ~-11 ~-1 ~88 ~-11 ~-1 ~108 mossy_stone_bricks
fill ~11 ~-1 ~88 ~11 ~-1 ~108 mossy_stone_bricks
fill ~-11 ~-1 ~88 ~11 ~-1 ~88 mossy_stone_bricks
fill ~-11 ~-1 ~108 ~11 ~-1 ~108 mossy_stone_bricks

# ============================================
# JAPANESE ARCHED BRIDGE (z=93 to z=103)
# Red concrete railings, polished andesite deck
# Arch shape: rises 2 blocks at center
# ============================================

# Bridge supports (stone bricks in water)
fill ~-3 ~-2 ~93 ~3 ~-2 ~93 stone_bricks
fill ~-3 ~-2 ~103 ~3 ~-2 ~103 stone_bricks
fill ~-3 ~-1 ~93 ~3 ~-1 ~93 stone_bricks
fill ~-3 ~-1 ~103 ~3 ~-1 ~103 stone_bricks

# Bridge deck - ascending
fill ~-2 ~0 ~93 ~2 ~0 ~94 polished_andesite
fill ~-2 ~0 ~102 ~2 ~0 ~103 polished_andesite

# Bridge deck - mid level
fill ~-2 ~1 ~95 ~2 ~1 ~96 polished_andesite
fill ~-2 ~1 ~100 ~2 ~1 ~101 polished_andesite

# Bridge deck - peak
fill ~-2 ~2 ~97 ~2 ~2 ~99 polished_andesite

# Bridge stairs (smooth transitions)
setblock ~-2 ~0 ~95 polished_andesite_stairs[facing=south,half=bottom]
setblock ~-1 ~0 ~95 polished_andesite_stairs[facing=south,half=bottom]
setblock ~0 ~0 ~95 polished_andesite_stairs[facing=south,half=bottom]
setblock ~1 ~0 ~95 polished_andesite_stairs[facing=south,half=bottom]
setblock ~2 ~0 ~95 polished_andesite_stairs[facing=south,half=bottom]

setblock ~-2 ~1 ~97 polished_andesite_stairs[facing=south,half=bottom]
setblock ~-1 ~1 ~97 polished_andesite_stairs[facing=south,half=bottom]
setblock ~0 ~1 ~97 polished_andesite_stairs[facing=south,half=bottom]
setblock ~1 ~1 ~97 polished_andesite_stairs[facing=south,half=bottom]
setblock ~2 ~1 ~97 polished_andesite_stairs[facing=south,half=bottom]

setblock ~-2 ~0 ~101 polished_andesite_stairs[facing=north,half=bottom]
setblock ~-1 ~0 ~101 polished_andesite_stairs[facing=north,half=bottom]
setblock ~0 ~0 ~101 polished_andesite_stairs[facing=north,half=bottom]
setblock ~1 ~0 ~101 polished_andesite_stairs[facing=north,half=bottom]
setblock ~2 ~0 ~101 polished_andesite_stairs[facing=north,half=bottom]

setblock ~-2 ~1 ~99 polished_andesite_stairs[facing=north,half=bottom]
setblock ~-1 ~1 ~99 polished_andesite_stairs[facing=north,half=bottom]
setblock ~0 ~1 ~99 polished_andesite_stairs[facing=north,half=bottom]
setblock ~1 ~1 ~99 polished_andesite_stairs[facing=north,half=bottom]
setblock ~2 ~1 ~99 polished_andesite_stairs[facing=north,half=bottom]

# Red concrete railings
fill ~-3 ~1 ~93 ~-3 ~1 ~94 red_concrete
fill ~3 ~1 ~93 ~3 ~1 ~94 red_concrete
fill ~-3 ~2 ~95 ~-3 ~2 ~96 red_concrete
fill ~3 ~2 ~95 ~3 ~2 ~96 red_concrete
fill ~-3 ~3 ~97 ~-3 ~3 ~99 red_concrete
fill ~3 ~3 ~97 ~3 ~3 ~99 red_concrete
fill ~-3 ~2 ~100 ~-3 ~2 ~101 red_concrete
fill ~3 ~2 ~100 ~3 ~2 ~101 red_concrete
fill ~-3 ~1 ~102 ~-3 ~1 ~103 red_concrete
fill ~3 ~1 ~102 ~3 ~1 ~103 red_concrete

# Bridge lanterns (at peak)
setblock ~-3 ~4 ~98 soul_lantern
setblock ~3 ~4 ~98 soul_lantern

# ============================================
# VILLAGE PATHS (connecting houses to courtyard)
# Polished andesite, 3 wide
# ============================================

# Path from courtyard to Didac's house (south, z=57 to z=61)
fill ~-1 ~-1 ~57 ~1 ~-1 ~61 polished_andesite

# Path from courtyard to Marc's house (west, x=-8 to x=-14)
fill ~-8 ~-1 ~49 ~-14 ~-1 ~51 polished_andesite

# Path from courtyard to Igor's house (northwest, diagonal-ish)
fill ~-7 ~-1 ~43 ~-7 ~-1 ~39 polished_andesite
fill ~-8 ~-1 ~39 ~-12 ~-1 ~39 polished_andesite

# Path from courtyard to Armando's house (northeast, diagonal-ish)
fill ~7 ~-1 ~43 ~7 ~-1 ~39 polished_andesite
fill ~8 ~-1 ~39 ~12 ~-1 ~39 polished_andesite

# Path from courtyard to Eric's house (east, x=8 to x=14)
fill ~8 ~-1 ~49 ~14 ~-1 ~51 polished_andesite

# ============================================
# PATH FROM NEIGHBORHOOD TO MAIN ROAD (z=57 to z=74)
# ============================================

fill ~-1 ~-1 ~57 ~1 ~-1 ~74 polished_andesite
fill ~-2 ~-1 ~57 ~-2 ~-1 ~74 dark_oak_planks
fill ~2 ~-1 ~57 ~2 ~-1 ~74 dark_oak_planks

# ============================================
# PATH FROM ATRIUM TO COURTYARD (z=24 to z=43)
# ============================================

fill ~-1 ~-1 ~24 ~1 ~-1 ~43 polished_andesite
fill ~-2 ~-1 ~24 ~-2 ~-1 ~43 dark_oak_planks
fill ~2 ~-1 ~24 ~2 ~-1 ~43 dark_oak_planks

# ============================================
# PATH FROM PLAZA TO ATRIUM (z=4 to z=5)
# ============================================

fill ~-2 ~-1 ~4 ~2 ~-1 ~5 polished_andesite
