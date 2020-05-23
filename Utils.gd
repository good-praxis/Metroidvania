extends Node

func instance_scene_on_main(scene: PackedScene, position: Vector2):
	var levels: = get_tree().get_nodes_in_group("Level")
	var level = levels[0]
	var instance: = scene.instance()
	level.add_child(instance)
	instance.global_position = position
	return instance


func random_pick(list: Array):
	if list.size() > 0:
		return list[randi()%list.size()]
	print("List provided to random pick is empty")

func get_level_name():
	var levels: = get_tree().get_nodes_in_group("Level")
	var level = levels[0]
	return level.name
