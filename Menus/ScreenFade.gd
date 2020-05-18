extends ColorRect

onready var anim: = $AnimationPlayer

func _ready():
# warning-ignore-all:return_value_discarded
	Events.connect("screen_fade_out", self, "fade_out")
	Events.connect("screen_fade_in", self, "fade_in")

func fade_out(speed = 1):
	Events.is_fading = true
	anim.playback_speed = speed
	anim.play("fade_out")

func fade_in(speed = 1):
	Events.is_fading = true
	anim.playback_speed = speed
	anim.play("fade_in")


func _on_AnimationPlayer_animation_finished(_anim_name):
	Events.is_fading = false
