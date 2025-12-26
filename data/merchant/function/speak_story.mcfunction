# 1. TEXTE AUSGEBEN (Je nach State)

# State 0: Der Anfang
execute if score #global story_state matches 0 run tellraw @a [{"text":"<Geist> ","color":"dark_purple","bold":true},{"text":"Verlorene Seele... ","color":"gray","italic":true},{"text":"Komm in der Nacht zu uns.","color":"gray"}]

# State 1: Nach dem ersten Fortschritt (z.B. Lizenz gekauft)
execute if score #global story_state matches 1 run tellraw @a [{"text":"<Geist> ","color":"dark_purple","bold":true},{"text":"Du lernst schnell. ","color":"gray","italic":true},{"text":"Doch die Dunkelheit ist hungrig.","color":"gray"}]

# State 2: Das Eisen-Zeitalter
execute if score #global story_state matches 2 run tellraw @a [{"text":"<Geist> ","color":"dark_purple","bold":true},{"text":"Das Metall der Erde... ","color":"gray","italic":true},{"text":"Wir haben neue Werkzeuge für dich.","color":"gray"}]


# 2. GEDÄCHTNIS UPDATE (WICHTIG!)
# Wir setzen last_spoken auf den aktuellen Stand. Damit wird dieser Text nie wiederholt.
scoreboard players operation #global last_spoken = #global story_state