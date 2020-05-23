extends "res://Levels/Level.gd"

var PlayerStats: PlayerStats = ResourceLoader.PlayerStats
var MainInstances: MainInstances = ResourceLoader.MainInstances

export(String, FILE, "*.tscn")  var new_level_path = "res://Levels/Level_Elevator01.tscn"

var channel: = 0 #Door Channel


func _on_GravityTrigger_area_triggered():
	Events.emit_signal("screenshake_on", 0.125)
	SoundFx.play("Falling", 0.7, -20)



func _on_FallFXTrigger_area_triggered():
	SoundFx.play("Falling", 0.5, -20)


func _on_ElevatorObstacles2_hit():
	PlayerStats.gun_broken = true
	Music.fade_out(2)


func _on_CameraDisconnectTrigger_area_triggered():
	var player = MainInstances.Player
	player.cameraFollow.update_position = false
	yield(get_tree().create_timer(1), "timeout")
	Events.emit_signal("add_screenshake", .5, .7)
	SoundFx.play("EnemyDie", .7, -10)
	yield(get_tree().create_timer(1), "timeout")
	Events.emit_signal("screen_fade_out", 2)
	yield(get_tree().create_timer(2), "timeout")
	player.emit_signal("hit_door", self)
	

