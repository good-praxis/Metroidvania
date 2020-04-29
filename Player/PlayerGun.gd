extends Node2D

const DustEffect = preload("res://Effects/DustEffect.tscn")

var PlayerStats = ResourceLoader.PlayerStats

onready var smokeTimer = $SmokeTimer
onready var smoke = $Sprite/Smoke

func _ready():
	PlayerStats.connect("player_gun_broken", self, "_on_player_gun_broken")

func _process(_delta):
	var player: = get_parent()
	rotation = player.get_local_mouse_position().angle()

func _on_player_gun_broken(broken):
	if broken:
		smokeTimer.start()
	else:
		smokeTimer.stop()
		

func _on_SmokeTimer_timeout():
	smokeTimer.wait_time = rand_range(0.1, 0.6)
	var dust = Utils.instance_scene_on_main(DustEffect, smoke.global_position)
	dust.scale = Vector2(0.5, 0.5)
	
