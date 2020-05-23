extends "res://Enemies/Enemy.gd"

enum DIRECTION {LEFT = -1, RIGHT = 1}

export(DIRECTION) var SWIMMING_DIRECTION = DIRECTION.RIGHT
export(float) var timeScale = 2

onready var sprite: = $Sprite
onready var wallCollide: = $WallCollide

var t = 0

func _ready():
	wallCollide.scale.x = SWIMMING_DIRECTION
	sprite.scale.x = SWIMMING_DIRECTION

func _physics_process(delta):
	if wallCollide.is_colliding():
		turn()
		
	t += delta * timeScale
	
	motion.x = MAX_SPEED * SWIMMING_DIRECTION
	motion.y = MAX_SPEED * sin(t) 
	
	motion = move_and_slide_with_snap(motion, Vector2.DOWN * 4, Vector2.UP, true, 4, deg2rad(46))

func turn():
	SWIMMING_DIRECTION *= -1
	sprite.scale.x *= -1
	wallCollide.scale.x *= -1
