extends Node

var PlayerStats = ResourceLoader.PlayerStats

var custom_data =  {
	missiles_unlocked = false,
	wall_slide_unlocked = false,
	double_jump_unlocked = false,
	boss_defeated = false,
	gun_broken = false,
	save_on_broken_save_station = false,
	saved_health = PlayerStats.max_health,
	elevator_cutscene_over = false,
#	level_01_cleared = false,
#	level_03_cleared = false
}

var is_loading := false

func save_game():
	var save_game: = File.new()
# warning-ignore:return_value_discarded
	save_game.open("user://savegame.save", File.WRITE)
	
	save_game.store_line(to_json(custom_data))
	
	var persistingNodes = get_tree().get_nodes_in_group("Persists")
	for node in persistingNodes:
		var node_data = node.save()
		save_game.store_line(to_json(node_data))
	save_game.close()

func load_game():
	var save_game: = File.new()
	if not save_game.file_exists("user://savegame.save"):
		return
	
	var persistingNodes = get_tree().get_nodes_in_group("Persists")
	for node in persistingNodes:
		node.queue_free()
		
# warning-ignore:return_value_discarded
	save_game.open("user://savegame.save", File.READ)
	
	if not save_game.eof_reached():
		custom_data = parse_json(save_game.get_line())
	
	while not save_game.eof_reached():
		var current_line: = save_game.get_line()
		if current_line != null and current_line.length() > 0:
			var save_data: Dictionary = parse_json(current_line)
			var newNode = load(save_data["filename"]).instance()
			get_node(save_data["parent"]).add_child(newNode, true)
			newNode.position = Vector2(save_data["position_x"], save_data["position_y"])
			for property in save_data.keys():
				if (property == "filename"
				or property == "parent"
				or property == "position_x"
				or property == "position_y"):
					continue
				newNode.set(property, save_data[property])
	save_game.close()
