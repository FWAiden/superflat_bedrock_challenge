scoreboard players set #spawn merchant_spawn_timer 0

execute unless entity @e[type=minecraft:wandering_trader,tag=challenge_trader] as @a at @s if block ~ ~-1 ~ minecraft:bedrock run function merchant:summon_trader
