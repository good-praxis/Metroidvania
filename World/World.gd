extends Node

var MainInstances: MainInstances = ResourceLoader.MainInstances
var PlayerStats: PlayerStats = ResourceLoader.PlayerStats

onready var currentLevel = get_current_level()

func _ready():
	VisualServer.set_default_clear_color(Color.black)
	Music.list_play()
	
	if SaverAndLoader.is_loading:
		SaverAndLoader.load_game()
		SaverAndLoader.is_loading = false
		
	var DebugHelper = MainInstances.DebugHelper
	if DebugHelper != null:
		DebugHelper.prime_player()
	
	MainInstances.Player.connect("hit_door", self, "_on_Player_hit_door")
	MainInstances.Player.connect("player_died", self, "_on_Player_died")
	
func change_levels(door):
	if currentLevel == null:
		push_warning("No current level found in World.gd")
		
	if door.new_level_path == "":
		Events.emit_signal("screen_fade_out", 1)
		PlayerStats.emit_signal("player_died")
		return
		
	var offset = currentLevel.position
	currentLevel.queue_free()
	var NewLevel = load(door.new_level_path)
	var newLevel = NewLevel.instance()
	add_child(newLevel)
	var newDoor = get_door_on_channel(door, door.channel)
	var exit_position = newDoor.position - offset
	newLevel.position = door.position - exit_position
	newLevel._world_ready()
	
func get_door_on_channel(notDoor, channel):
	var doors = get_tree().get_nodes_in_group("Door")
	for door in doors:
		if door.channel == channel and door != notDoor:
			return door
	return null

func get_current_level():
	for child in get_children():
		if child.is_in_group("Level"):
			return child

func _on_Player_hit_door(door):
	call_deferred("change_levels", door)
	
func _on_Player_died():
	yield(get_tree().create_timer(1.0), "timeout")
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Menus/GameOverMenu.tscn")

