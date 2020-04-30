extends "res://Enemies/Enemy.gd"

const DustEffect = preload("res://Effects/DustEffect.tscn")

signal died

func emit_dust():
	var dust_position = global_position + Vector2(rand_range(-2, 1), 8)
	var dustEffect = Utils.instance_scene_on_main(DustEffect, dust_position)
	dustEffect.scale = Vector2(.7, .7)
	
func _on_EnemyStats_enemy_died():
	emit_signal("died")
	._on_EnemyStats_enemy_died()

