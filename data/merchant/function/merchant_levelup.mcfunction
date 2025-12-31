# 1. Das Item entfernen (WICHTIG! Sonst loopt es unendlich)
clear @s minecraft:paper[minecraft:custom_name='{"text":"Handelslizenz"}'] 1

# 2. Das globale Level erhöhen
scoreboard players add #level merchant_data 1

# 3. Feedback: Sound abspielen
playsound ui.toast.challenge_complete master @s ~ ~ ~ 1 1

# 4. Feedback: Text anzeigen
title @s times 10 40 20
title @s subtitle {"text":"Der nächste Händler hat bessere Ware!","color":"yellow"}
title @s title {"text":"Level Up!","color":"gold","bold":true}

# 5. Chat-Nachricht zur Bestätigung
tellraw @s ["",{"text":"[Merchant] ","color":"gray"},{"text":"Du hast Level ","color":"green"},{"score":{"name":"#level","objective":"merchant_data"},"color":"gold","bold":true},{"text":" erreicht!","color":"green"}]