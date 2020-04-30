extends "res://Enemies/Enemy.gd"

enum SPRITES {HELMET, HEART, HAPPY, EXCITED, SAD, CROSS, PREJUMP, JUMP_ONE, 
	POSTJUMP, JUMP_TWO, SPIKE, RIGHT, UP, DOWN, EMPTY}
	

onready var displaySprite: = $Sprite/DisplaySprite
onready var animationPlayer: = $AnimationPlayer

export(bool) var animated = false setget set_animated
export(String, "None", "GoRight") var animation setget set_animation
export(SPRITES) var sprite_id setget set_sprite_id

func set_animated(value):
	animated = value

func set_animation(value):
	animation = value

func set_sprite_id(value):
	sprite_id = value
	if not animated and displaySprite:
		update_sprite()
	
func _ready():
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
