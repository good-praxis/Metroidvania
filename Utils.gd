extends Node

func instance_scene_on_main(scene: PackedScene, position: Vector2):
	var levels: = get_tree().get_nodes_in_group("Level")
	var level = levels[0]
	var instance: = scene.instance()
	level.add_child(instance)
	instance.global_position = position
	return instance
