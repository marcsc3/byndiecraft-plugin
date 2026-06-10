# GitHub Temple Tower - Main (calls sub-functions)
# Position: center ~32 ~0 ~-4, entrance faces WEST
# 29x29 base, 5-tier pagoda, ~35 blocks tall

# Foundation (31x31 polished deepslate)
fill ~17 ~-1 ~-19 ~47 ~-1 ~11 polished_deepslate

# Platform floor (29x29 white concrete)
fill ~18 ~0 ~-18 ~46 ~0 ~10 white_concrete

# Floor border (gray concrete frame)
fill ~18 ~0 ~-18 ~46 ~0 ~-18 gray_concrete
fill ~18 ~0 ~10 ~46 ~0 ~10 gray_concrete
fill ~18 ~0 ~-18 ~18 ~0 ~10 gray_concrete
fill ~46 ~0 ~-18 ~46 ~0 ~10 gray_concrete

# Build sub-parts
execute positioned 0 -60 0 run function byndiecraft:github_tower_logo
execute positioned 0 -60 0 run function byndiecraft:github_tower_tiers
execute positioned 0 -60 0 run function byndiecraft:github_tower_entrance
