extends "res://Levels/Level.gd"

onready var blockDoor := $BlockDoor

func _ready():
	if SaverAndLoader.custom_data.level_03_cleared:
		set_block_door(false)
		set_spikes_to_cleared()
		
	else:
		connect_signals()
		set_block_door(true)


func set_block_door(active: bool) -> void:
	blockDoor.visible = active
	blockDoor.set_collision_mask_bit(PLAYER_BIT, active)
	blockDoor.set_collision_mask_bit(WORLD_BIT, active)
	
func 
