extends Node2D

const WORLD = preload("res://World/World.gd")
const PLAYER_BIT = 0
const WORLD_BIT = 2

func _ready():
	var parent = get_parent()
	if parent is WORLD:
		parent.currentLevel = self
		
func _world_ready():
	pass

func save() -> Dictionary:
	var save_dictionary: = {
		"filename" : get_filename(),
		"parent" : get_parent().get_path(),
		"position_x" : position.x,
		"position_y" : position.y
	}
	return save_dictionary
