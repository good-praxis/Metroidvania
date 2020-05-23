extends "res://Enemies/Enemy.gd"

enum DIRECTION {LEFT = -1, RIGHT = 1}

export(DIRECTION) var CURRENT_DIRECTION = DIRECTION.RIGHT
export(float) var timeScale = 2
export(float) var time_until_turn = 1

onready var sprite: = $Sprite
onready var blinkTimer: = $BlinkTimer
onready var dashTimer: = $DashTimer
onready var turnTimer: = $TurnTimer

var floatBorder = Vector2(-8, 8)
var t = 0

func _ready():
	turnTimer.wait_time = time_until_turn
	turnTimer.start()

func _physics_process(delta):
	t += delta * timeScale
	
	motion.x = MAX_SPEED * CURRENT_DIRECTION
	motion.y = MAX_SPEED * sin(t) 
	
	sprite.scale.x = sign(motion.x)
	motion = move_and_slide_with_snap(motion, Vector2.DOWN * 4, Vector2.UP, true, 4, deg2rad(46))


func _on_DashTimer_timeout():
	pass # Replace with function body.


func _on_BlinkTimer_timeout():
	pass # Replace with function body.


func _on_TurnTimer_timeout():
	CURRENT_DIRECTION *= -1
