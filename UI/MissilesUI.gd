extends HBoxContainer

var PlayerStats: PlayerStats = ResourceLoader.PlayerStats

onready var label: = $Label

func _ready():
# warning-ignore-all:return_value_discarded
	PlayerStats.connect("player_missiles_changed", self, "_on_player_missiles_changed")
	PlayerStats.connect("player_missiles_unlocked", self, "_on_player_missiles_unlocked")
	
func _on_player_missiles_changed(amount):
	label.text = str(amount)

func _on_player_missiles_unlocked(value):
	visible = value
