# 1. Markiere MICH (den Neuen) als "neu", damit ich nicht gelöscht werde
tag @s add is_new

# 2. Teleportiere alle ANDEREN Challenge-Trader ins Void (lautloses Despawn)
# Erklärung: Wähle alle Trader mit "challenge_trader", die NICHT (!=) "is_new" sind.
execute as @e[type=minecraft:wandering_trader,tag=challenge_trader,tag=!is_new] run tp @s ~ -500 ~

# (Optional) Sicherheitshalber die alten auch killen, damit sie sicher weg sind
execute as @e[type=minecraft:wandering_trader,tag=challenge_trader,tag=!is_new] run kill @s

# 3. Entferne meine "Neu"-Markierung wieder, damit ich beim nächsten Mal der "Alte" bin
tag @s remove is_new

summon minecraft:wandering_trader ~10 ~ ~ {Tags:["challenge_trader"],DeathLootTable:"merchant:trader_loot"}
scoreboard players set @e[type=minecraft:wandering_trader,tag=challenge_trader,limit=1,sort=nearest] merchant_lifetime 0
execute as @e[type=minecraft:wandering_trader,tag=challenge_trader,limit=1,sort=nearest] run function merchant:assign_trades

playsound entity.illusioner.prepare_mirror master @a ~ ~ ~ 1 0.5
title @a times 10 60 20
title @a subtitle {"text":"Suche sein Licht...","color":"gray"}
title @a title {"text":"Ein Geist ist erschienen!","color":"dark_purple"}