# Erstelle alle Scoreboards, damit mit ihnen und ihren Werten gearbeitet werden kann

scoreboard objectives add merchant_spawn_timer dummy
scoreboard objectives add merchant_lifetime dummy
scoreboard objectives add timeskip dummy
# zurücksetzen im chat mit: /scoreboard players set #level merchant_data 1
scoreboard objectives add merchant_data dummy
# Zählt Rechtsklicks mit einer Wirrenpilzrute (für Timeskip Erkennung mit Rechtsklick)
scoreboard objectives add click_token minecraft.used:minecraft.warped_fungus_on_a_stick

# Erstelle das Scoreboard für den Story-Fortschritt
scoreboard objectives add story_state dummy "Story Fortschritt"

# Initialisiere den Status auf 0, falls er noch gar nicht existiert
execute unless score #global story_state matches 0.. run scoreboard players set #global story_state 0

# Das Gedächtnis: Welchen Story-Text hat er schon gesagt?
scoreboard objectives add last_spoken dummy

# Startwert für das Gedächtnis auf -1 setzen (falls es noch nicht existiert)
# Damit ist Story 0 > -1 und wird beim ersten Mal ausgelöst.
execute unless score #global last_spoken matches -1.. run scoreboard players set #global last_spoken -1