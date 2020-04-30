extends "res://Levels/Level.gd"


onready var blockDoor := $BlockDoor

onready var objective_count: = get_tree().get_nodes_in_group("Objective").size()

func _ready():
	if SaverAndLoader.custom_data.level_01_cleared:
		destory_objectives()
		set_block_door(false)
	else:
		connect_signals()
		set_block_door(true)

			
func destory_objectives():
	var objectives = get_tree().get_nodes_in_group("Objective")
	for targetDrone in objectives:
		targetDrone.queue_free()
		
func connect_signals():
	var objectives = get_tree().get_nodes_in_group("Objective")
	for targetDrone in objectives:
		targetDrone.connect("died", self, "_on_objective_cleared")

func set_block_door(active: bool) -> void:
	blockDoor.visible = active
	blockDoor.set_collision_mask_bit(PLAYER_BIT, active)
	blockDoor.set_collision_mask_bit(WORLD_BIT, active)
		
		
func _on_objective_cleared():
	objective_count -= 1
	if objective_count == 0:
		SoundFx.play("Powerup", 1.3)
		set_block_door(false)
		SaverAndLoader.custom_data.level_01_cleared = true
		
