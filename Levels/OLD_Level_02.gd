extends "res://Levels/Level.gd"

onready var boss: = $BossEnemy
onready var blockDoor: = $BlockDoor

func _ready():
	boss.visible = false

func set_block_door(active: bool) -> void:
	blockDoor.visible = active
	blockDoor.set_collision_mask_bit(PLAYER_BIT, active)
	blockDoor.set_collision_mask_bit(WORLD_BIT, active)

func _on_Trigger_area_triggered():
	if not SaverAndLoader.custom_data.boss_defeated:
		set_block_door(true)
		boss.visible = true


func _on_BossEnemy_died():
	set_block_door(false)
