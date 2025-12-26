# --- A) PRÜFUNG: GIBT ES ETWAS NEUES ZU SAGEN? ---
# Wir kopieren den aktuellen Status in einen temporären Score, um zu vergleichen
scoreboard players operation #temp story_state = #global story_state

# Wenn der aktuelle Status GRÖSSER ist als das, was zuletzt gesagt wurde...
# ...dann führen wir den Story-Block aus.
execute if score #global story_state > #global last_spoken run function merchant:speak_story

# --- B) STANDARD BEGRÜSSUNG (Wenn es nichts Neues gibt) ---
# Wenn der Status GLEICH dem letzten ist, sagen wir nur kurz Hallo.
execute unless score #global story_state > #global last_spoken run function merchant:speak_generic