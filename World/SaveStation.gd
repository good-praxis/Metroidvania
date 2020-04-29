extends StaticBody2D

var PlayerStats: PlayerStats = ResourceLoader.PlayerStats

onready var animationPlayer: = $AnimationPlayer

func _on_SaveArea_body_entered(_body):
	animationPlayer.play("Save")
	SoundFx.play("Powerup", 0.6, -10)
	SaverAndLoader.custom_data.save_on_broken_save_station = false
	SaverAndLoader.save_game()
	PlayerStats.refill_stats()

