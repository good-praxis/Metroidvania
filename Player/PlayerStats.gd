extends Resource
class_name PlayerStats

var max_health: = 4
var health = max_health setget set_health
var max_missiles: = 3
var missiles: = max_missiles setget set_missiles
var missiles_unlocked: = false setget set_missiles_unlocked
var wall_slide_unlocked: = false setget set_wall_slide_unlocked
var double_jump_unlocked: = false setget set_double_jump_unlocked
var gun_broken: = false setget set_gun_broken

var connected_to_events: = true

signal player_health_changed(value)
signal player_missiles_changed(value)
signal player_missiles_unlocked(value)
signal player_wall_slide_unlocked(value)
signal player_double_jump_unlocked(value)
signal player_gun_broken(value)
signal player_died

func set_health(value):
	if connected_to_events && value < health:
		Events.emit_signal("add_screenshake", 0.25, 0.5)
	health = clamp(value, 0, max_health) as int
	emit_signal("player_health_changed", health)
	if health == 0:
		emit_signal("player_died")

func set_missiles(value):
	missiles = clamp(value, 0, max_missiles) as int
	emit_signal("player_missiles_changed", missiles)
	
func set_missiles_unlocked(value):
	missiles_unlocked = value
	SaverAndLoader.custom_data.missiles_unlocked = value
	emit_signal("player_missiles_unlocked", missiles_unlocked)
	
func set_wall_slide_unlocked(value):
	wall_slide_unlocked = value
	SaverAndLoader.custom_data.wall_slide_unlocked = value
	emit_signal("player_wall_slide_unlocked", wall_slide_unlocked)
	
func set_double_jump_unlocked(value):
	double_jump_unlocked = value
	SaverAndLoader.custom_data.double_jump_unlocked = value
	emit_signal("player_double_jump_unlocked", double_jump_unlocked)
	
func set_gun_broken(value):
	gun_broken = value
	SaverAndLoader.custom_data.gun_broken = value
	emit_signal("player_gun_broken", gun_broken)
	
func refill_stats():
	self.health = max_health
	self.missiles = max_missiles
