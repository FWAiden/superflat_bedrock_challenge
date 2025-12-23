# --- TRADES ZUWEISEN NACH LEVEL ---
# Wir prüfen die globale Variable #level

execute if score #level merchant_data matches 1 run function merchant:trades_common
execute if score #level merchant_data matches 2 run function merchant:trades_uncommon
execute if score #level merchant_data matches 3.. run function merchant:trades_rare