extends "res://Levels/Level.gd"

var MainInstances: MainInstances = ResourceLoader.MainInstances

export (Vector2) var spawnPosition = Vector2(0.0, 15.0)

func _ready():
	if !SaverAndLoader.custom_data.elevator_cutscene_over:
		var player = MainInstances.Player
		player.global_position = Vector2.ZERO
		player.cameraFollow.update_position = true
		yield(get_tree().create_timer(1), "timeout")
		player.knock_out()
		Events.emit_signal("screen_fade_in", 2)
		SaverAndLoader.custom_data.elevator_cutscene_over = true
	
