extends "res://Levels/Level.gd"

onready var blockDoor: = $BlockDoor
	
func set_block_door(active: bool) -> void:
	blockDoor.visible = active
	blockDoor.set_collision_mask_bit(PLAYER_BIT, active)
	blockDoor.set_collision_mask_bit(WORLD_BIT, active)

func _on_Trigger_area_triggered():
	set_block_door(true)
	Events.emit_signal("screenshake_off")
	SoundFx.play("Gurgle", 0.45, 1)
	Events.emit_signal("add_screenshake", .25, 1)
	Music.adjust_volume(-10)
