# --- 1. AUFRÄUMEN ---
# Wir töten zuerst ALLE alten Trader, bevor wir den neuen holen.
# Da wir den neuen noch nicht beschworen haben, brauchen wir keine "is_new" Schutzmechanik.
execute as @e[type=minecraft:wandering_trader,tag=challenge_trader] run particle minecraft:poof ~ ~1 ~ 0.5 0.5 0.5 0.1 10
execute as @e[type=minecraft:wandering_trader,tag=challenge_trader] run kill @s


# --- 2. BESCHWÖREN (Der Fels in der Brandung) ---
# Wir setzen Attribute UND geben ihm tags direkt mit.
# WICHTIG: Invulnerable:1b verhindert Schaden und Knockback durch Spieler-Schläge komplett.
summon minecraft:wandering_trader ~ ~ ~ {Tags:["challenge_trader","is_new"], DeathLootTable:"merchant:trader_loot", DespawnDelay:2147483647, Invulnerable:1b, Attributes:[{Name:"minecraft:movement_speed",Base:0.0}, {Name:"minecraft:knockback_resistance",Base:1.0}]}


# --- 3. SICHERHEIT: BEWEGUNG EINFRIEREN ---
# Falls Attribute versagen: Slowness 255 friert Bewegung ein, erlaubt aber Umschauen.
# "true" am Ende versteckt die Partikel.
effect give @e[type=minecraft:wandering_trader,tag=is_new] minecraft:slowness infinite 255 true


# --- 4. HANDEL & SETUP ---
scoreboard players set @e[type=minecraft:wandering_trader,tag=is_new] merchant_lifetime 0

# Führe die Handels-Funktion nur für den neuen Händler aus
execute as @e[type=minecraft:wandering_trader,tag=is_new] run function merchant:assign_trades


# --- 5. EFFEKTE & FINISH ---
playsound entity.illusioner.prepare_mirror master @a ~ ~ ~ 1 0.5
title @a times 10 60 20
title @a subtitle {"text":"Suche sein Licht...","color":"gray"}
title @a title {"text":"Ein Geist ist erschienen!","color":"dark_purple"}


# --- 6. TAG ENTFERNEN ---
# Jetzt ist er nicht mehr "neu" und reiht sich in die normalen Trader ein.
tag @e[type=minecraft:wandering_trader,tag=is_new] remove is_new

# Am Ende: Der Geist spricht basierend auf dem aktuellen Story-State
function merchant:speak_spawn