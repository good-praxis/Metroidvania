extends "res://Levels/Level.gd"

var MainInstances: MainInstances = ResourceLoader.MainInstances

onready var oneWayDoor: = $OneWayDoor

export (Vector2) var spawnOffset = Vector2(0.0, 15.0)

func _world_ready():
	if !SaverAndLoader.custom_data.elevator_cutscene_over:
		var player = MainInstances.Player
		player.position = global_position + oneWayDoor.position + spawnOffset
		player.cameraFollow.update_position = true
		yield(get_tree().create_timer(1), "timeout")
		player.knock_out()
		Events.emit_signal("screen_fade_in", 2)
		SaverAndLoader.custom_data.elevator_cutscene_over = true
	
