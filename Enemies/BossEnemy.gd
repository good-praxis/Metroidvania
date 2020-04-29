extends "res://Enemies/Enemy.gd"

var MainInstances: MainInstances = ResourceLoader.MainInstances
const Bullet = preload("res://Enemies/EnemyBullet.tscn")
var awake: = true setget set_awake

export(int) var ACCELERATION: = 70

onready var animationPlayer = $AnimationPlayer
onready var rightWallCheck: = $RightWallCheck
onready var leftWallCheck: = $LeftWallCheck

signal died

func _ready():
	if SaverAndLoader.custom_data.boss_defeated:
		queue_free()

func _process(delta):
	chase_player(delta)
	
func chase_player(delta):
	var player = MainInstances.Player
	if player != null:
		var direction_to_move: = sign(player.global_position.x - global_position.x)
		motion.x += ACCELERATION * delta * direction_to_move
		motion.x = clamp(motion.x, -MAX_SPEED, MAX_SPEED)
		global_position.x += motion.x * delta
		rotation_degrees = lerp(rotation_degrees, (motion.x / MAX_SPEED) * 10, 0.3)
		
		if colliding_with_wall():
			motion.x *= -0.5
			
func fire_bullet() -> void:
	var bullet = Utils.instance_scene_on_main(Bullet, global_position)
	var velocity: = Vector2.DOWN * 50
	velocity = velocity.rotated(deg2rad(rand_range(-30, 30)))
	bullet.velocity = velocity
		
func colliding_with_wall() -> bool:
	return ((rightWallCheck.is_colliding() and motion.x > 0) or 
		(leftWallCheck.is_colliding() and motion.x < 0))

func set_awake(value):
	visible = value
	set_process(value)
	awake = value
	

func _on_ProjectileTimer_timeout():
	if awake:
		fire_bullet()
	
func _on_EnemyStats_enemy_died():
	emit_signal("died")
	SaverAndLoader.custom_data.boss_defeated = true
	._on_EnemyStats_enemy_died()
