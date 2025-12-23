# Erstelle alle Scoreboards, damit mit ihnen und ihren Werten gearbeitet werden kann

scoreboard objectives add merchant_spawn_timer dummy
scoreboard objectives add merchant_lifetime dummy
scoreboard objectives add timeskip dummy
# zurücksetzen im chat mit: /scoreboard players set #level merchant_data 1
scoreboard objectives add merchant_data dummy
# Zählt Rechtsklicks mit einer Wirrenpilzrute (für Timeskip Erkennung mit Rechtsklick)
scoreboard objectives add click_token minecraft.used:minecraft.warped_fungus_on_a_stick