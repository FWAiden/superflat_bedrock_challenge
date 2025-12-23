# 1. Item aus der Hand löschen
clear @s minecraft:warped_fungus_on_a_stick[minecraft:custom_name='{"Time Token"}'] 1

# 2. BERECHNUNG: Wie lange noch bis zum Morgen (24000)?
# Wir setzen die Skip-Variable erstmal auf 24000 (das Ziel)
scoreboard players set #skip timeskip 24000

# Wir ziehen die aktuelle Uhrzeit davon ab (#current_time wird in tick.mcfunction aktualisiert)
# Rechenoperation: #skip = #skip - #current_time
scoreboard players operation #skip timeskip -= #current_time merchant_lifetime

# 3. Sound und Effekt
playsound block.beacon.activate master @a ~ ~ ~ 1 2
title @a actionbar {"text":"Die Nacht vergeht wie im Flug...","color":"aqua"}