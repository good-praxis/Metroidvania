extends "res://Player/Projectile.gd"

func _ready():
	SoundFx.play("Bullet", rand_range(0.8, 1.2))
	set_process(false)

