extends "res://Enemies/Enemy.gd"

enum SPRITES {HELMET, HEART, HAPPY, EXCITED, SAD, CROSS, PREJUMP, JUMP_ONE, 
	POSTJUMP, JUMP_TWO, SPIKE, RIGHT, UP, DOWN, GUN, TARGET, SAVE_STATION, EMPTY}
	

var running = true
var completed = false
var interrupted_state

onready var displaySprite: = $Sprite/DisplaySprite
onready var animationPlayer: = $AnimationPlayer
onready var emoteTimer: = $EmoteTimer

export(bool) var animated = false 
export(String, "None", "GoRight", "ShootTarget") var animation 
export(SPRITES) var sprite_id 

	
func _ready():
	run()
	
func run():
	running = true
	if not animated:
		update_sprite()
	else:
		if animation == "None":
			return
		play_animation()
		
func update_sprite():
	displaySprite.frame = sprite_id
	
func play_animation(anim = animation):
	animationPlayer.play(anim)

func room_cleared():
	if running:
		animationPlayer.stop()
	running = false
	completed = true
	
	play_animation("GoRight")

func _on_objective_cleared():
	if running:
		running = false
		interrupted_state = [animated, animation, sprite_id]
	animated = false
	animationPlayer.stop()
	sprite_id = SPRITES.EXCITED
	update_sprite()
	emoteTimer.start(1)
	

func _on_EmoteTimer_timeout():
	if not completed:
		animated = interrupted_state[0]
		animation = interrupted_state[1]
		sprite_id = interrupted_state[2]
		run()
	else:
		room_cleared()
	
