extends "res://Enemies/Enemy.gd"

enum DIRECTION {UP = -1, DOWN = 1}

export(DIRECTION) var SWIMMING_DIRECTION = DIRECTION.UP setget set_direction

onready var wallCollide: = $WallCollide

func _ready():
	wallCollide.scale.y = -1 * SWIMMING_DIRECTION
	
func _physics_process(_delta):
	if wallCollide.is_colliding():
		turn()
	
	motion.y = MAX_SPEED * SWIMMING_DIRECTION
	
	motion = move_and_slide_with_snap(motion, Vector2.DOWN * 4, Vector2.UP, true, 4, deg2rad(46))

func set_direction(new_direction):
	SWIMMING_DIRECTION = new_direction
	if mounted():
		wallCollide.scale.x = new_direction

func mounted() -> bool:
	return wallCollide != null

func turn():
	SWIMMING_DIRECTION *= -1
	wallCollide.scale.y *= -1
