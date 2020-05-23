extends Area2D

export(int, -1, 4) var channel = -1
export(String, FILE, "*.tscn") var new_level_path: = ""
export(bool) var oneshot = false

var active: = true

func _ready():
	if oneshot:
		queue_free()

func _on_Door_body_entered(Player):
	if active == true:
		Player.emit_signal("hit_door", self)
		active = false
