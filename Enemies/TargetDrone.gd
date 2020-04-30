extends "res://Enemies/Enemy.gd"

const DustEffect = preload("res://Effects/DustEffect.tscn")

func emit_dust():
	var dust_position = global_position + Vector2(rand_range(-2, 1), 8)
	var dustEffect = Utils.instance_scene_on_main(DustEffect, dust_position)
	dustEffect.scale = Vector2(.7, .7)

