extends "res://Enemies/Enemy.gd"

const EnemyBullet = preload("res://Enemies/EnemyBullet.tscn")

export(int) var BULLET_SPEED: = 30
export(float) var SPREAD: = 30.0
export(bool) var sleep: = false

onready var fireDirection = $FireDirection
onready var bulletSpawnPoint = $BulletSpawnPoint
onready var anim = $AnimationPlayer

func _ready():
	if sleep:
		anim.stop()
		
func _on_Hurtbox_hit(damage):
	sleep = false
	anim.play("Animate")
	._on_Hurtbox_hit(damage)

func fire_bullet():
	var bullet = Utils.instance_scene_on_main(EnemyBullet, bulletSpawnPoint.global_position)
	var velocity: Vector2 = (fireDirection.global_position - global_position).normalized() * BULLET_SPEED
	velocity = velocity.rotated(deg2rad(rand_range(-SPREAD/2, SPREAD/2)))
	bullet.velocity = velocity
