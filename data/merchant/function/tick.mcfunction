# 20 Ticks pro Sekunde

# Wir speichern die aktuelle Tageszeit in einer Variable
execute store result score #current_time merchant_lifetime run time query daytime

# Spawn-Timer hochzählen
scoreboard players add #spawn merchant_spawn_timer 1

# --- HANDEL INITIALISIERUNG (Start auf Level 1 erzwingen) ---
# solange in der Liste merchant_data kein Eintrag für #level ist, der 1 oder größer ist, setze diesen Eintrag auf 1
# zurücksetzen im chat mit: /scoreboard players set #level merchant_data 1
execute unless score #level merchant_data matches 1.. run scoreboard players set #level merchant_data 1

# --- HANDEL LEVEL-UP ERKENNUNG ---
# Prüft, ob ein Spieler die "Handelslizenz" im Inventar hat und startet das Upgrade.
# (Achte darauf, dass der Name exakt mit dem in deinem Trade übereinstimmt!)
execute as @a[nbt={Inventory:[{id:"minecraft:paper",components:{"minecraft:custom_name":'{"text":"Handelslizenz"}'}}]}] run function merchant:merchant_levelup

# Wenn 10 Minuten (12000 Ticks) um sind:
# 1. Setze Timer zurück auf 0
execute if score #spawn merchant_spawn_timer matches 12000.. run scoreboard players set #spawn merchant_spawn_timer 0
# 2. Setze die "Warteschlange" (Pending) auf 1 -> "Ein Händler ist bereit!"
execute if score #spawn merchant_spawn_timer matches 0 run scoreboard players set #pending merchant_spawn_timer 1

# --- SPAWN AUSFÜHREN (NUR NACHTS) ---
# Bedingung: Wenn "Pending" auf 1 steht UND es Nacht ist (13000 bis 23500)
# Dann: Spawne den Händler
execute if score #pending merchant_spawn_timer matches 1 if score #current_time merchant_lifetime matches 13000..23500 run function merchant:spawn_trader
# Dann: Setze "Pending" sofort wieder auf 0 (damit er nicht 20x pro Sekunde spawnt)
execute if score #pending merchant_spawn_timer matches 1 if score #current_time merchant_lifetime matches 13000..23500 run scoreboard players set #pending merchant_spawn_timer 0



# --- TIMESKIP ITEM (RECHTSKLICK LOGIK) ---

# A) ERFOLG: Spieler klickt + hat Item + es ist NACHT (13000 bis 23999)
# Wir prüfen: Score > 0, Item in Hand, Zeit ist Nacht.
execute as @a[scores={click_token=1..},nbt={SelectedItem:{id:"minecraft:warped_fungus_on_a_stick",components:{"minecraft:custom_name":'{"text":"Time Token"}'}}}] at @s if score #current_time merchant_lifetime matches 13000.. run function merchant:start_timeskip

# 2 Lösche das Item direkt aus der Hand 
execute as @a[scores={click_token=1..},nbt={SelectedItem:{id:"minecraft:warped_fungus_on_a_stick",components:{"minecraft:custom_name":'{"text":"Time Token"}'}}}] at @s if score #current_time merchant_lifetime matches 13000.. run item replace entity @s weapon.mainhand with air

# B) FEHLER: Spieler klickt + hat Item + es ist TAG (0 bis 12999)
# Optional: Gib dem Spieler Feedback, dass es nur nachts geht. (Das Item wird NICHT gelöscht, da start_timeskip nicht läuft)
execute as @a[scores={click_token=1..},nbt={SelectedItem:{id:"minecraft:warped_fungus_on_a_stick",components:{"minecraft:custom_name":'{"text":"Time Token"}'}}}] at @s unless score #current_time merchant_lifetime matches 13000.. run title @s actionbar {"text":"Der Token funktioniert nur nachts!","color":"red"}

# --- REGEN ITEM (RECHTSKLICK LOGIK) ---

# 1. AUSFÜHREN: Setzt Regen für 100000 Ticks (Rains keeps stopping and it's pissing me)
execute as @a[scores={click_token=1..},nbt={SelectedItem:{id:"minecraft:warped_fungus_on_a_stick",components:{"minecraft:custom_name":'{"text":"Regen-Totem"}'}}}] at @s run weather rain 12000

# Optional: Sound abspielen (Donner)
execute as @a[scores={click_token=1..},nbt={SelectedItem:{id:"minecraft:warped_fungus_on_a_stick",components:{"minecraft:custom_name":'{"text":"Regen-Totem"}'}}}] at @s run playsound minecraft:entity.lightning_bolt.thunder master @a ~ ~ ~ 1 1

# Optional: Nachricht
execute as @a[scores={click_token=1..},nbt={SelectedItem:{id:"minecraft:warped_fungus_on_a_stick",components:{"minecraft:custom_name":'{"text":"Regen-Totem"}'}}}] at @s run title @a actionbar {"text":"Die Geister weinen...","color":"blue"}

# 2. LÖSCHEN: Item aus der Hand entfernen
execute as @a[scores={click_token=1..},nbt={SelectedItem:{id:"minecraft:warped_fungus_on_a_stick",components:{"minecraft:custom_name":'{"text":"Regen-Totem"}'}}}] at @s run item replace entity @s weapon.mainhand with air

# RESET: Klick-Score immer zurücksetzen nach allen Klick Aktionen
scoreboard players set @a[scores={click_token=1..}] click_token 0

# --- TIMESKIP AUSFÜHREN ---
# Wenn #skip > 0 ist, läuft die Zeit vorwärts (definiert in run_timeskip)
execute if score #skip timeskip matches 1.. run function merchant:run_timeskip



# Wenn es Tag ist (0 bis 12999) UND ein Challenge-Trader existiert:
# Zeige Partikel (Rauch), damit es aussieht, als würde er verbrennen/verpuffen
execute if score #current_time merchant_lifetime matches 0..12999 at @e[type=minecraft:wandering_trader,tag=challenge_trader] run particle minecraft:poof ~ ~1 ~ 0.5 0.5 0.5 0.1 10

# Teleportiere ihn ins Void (Despawn)
execute if score #current_time merchant_lifetime matches 0..12999 as @e[type=minecraft:wandering_trader,tag=challenge_trader] run tp @s ~ -500 ~

# Gib Händler immer eine soul lantern in die Hand
item replace entity @e[type=minecraft:wandering_trader,tag=challenge_trader] weapon.mainhand with minecraft:soul_lantern

# Mache Händler immer unsichtbar
effect give @e[type=minecraft:wandering_trader,tag=challenge_trader] minecraft:invisibility infinite 0 true

# Konstanter Partikeleffekt um Händler
execute at @e[type=minecraft:wandering_trader,tag=challenge_trader] run particle minecraft:sculk_soul ~ ~0.8 ~ 0.2 0.4 0.2 0.05 1

# 1. VERHINDERE UNSICHTBARKEIT
# Entfernt den Effekt "invisibility" sofort von allen Challenge-Tradern
# effect clear @e[type=minecraft:wandering_trader,tag=challenge_trader] minecraft:invisibility

# 2. SCHNEE-SPUR (Optional)
# Setzt eine Schneeschicht an der Position des Händlers, aber nur, wenn dort Luft ist ("keep")
execute at @e[type=minecraft:wandering_trader,tag=challenge_trader] run setblock ~ ~ ~ minecraft:snow[layers=1] keep


