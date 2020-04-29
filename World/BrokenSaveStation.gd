extends "res://World/SaveStation.gd"

const DustEffect = preload("res://Effects/DustEffect.tscn")

onready var pitchTween: = $PitchTween
onready var smokeTimer: = $SmokeTimer

func _on_SaveArea_body_entered(_body):
	animationPlayer.play("Save")
	var start_pitch = 0.6
	var soundFxPlayer = SoundFx.playAndReturn("Powerup", start_pitch, -10)
	pitchTween.interpolate_property(soundFxPlayer, "pitch_scale", start_pitch, 0.1, .6,Tween.TRANS_SINE, Tween.EASE_IN)
	pitchTween.start()
	SaverAndLoader.custom_data.save_on_broken_save_station = true
	SaverAndLoader.custom_data.saved_health = PlayerStats.health
	SaverAndLoader.save_game()


func _on_SmokeTimer_timeout():
	smokeTimer.wait_time = rand_range(.6, 1.4)
	var possible_y = [-26, -4]
	var offset = Vector2(rand_range(-9, 9), Utils.random_pick(possible_y))
	var dustEffect = Utils.instance_scene_on_main(DustEffect, global_position + offset)
	dustEffect.scale = Vector2(1.5, 1.5)
