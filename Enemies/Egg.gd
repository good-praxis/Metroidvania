extends "res://Enemies/Enemy.gd"

export(bool) var dead: = false

var id: String

onready var anim: = $AnimationPlayer

func _ready():
	generate_identifier()
	dead_check()
	if dead:
		anim.play("Dead")

func dead_check():
	dead = SaverAndLoader.custom_data.get(id, dead)
	
func generate_identifier():
	var level_name = Utils.get_level_name()
	
	id = "%s-%s" % [level_name, name]
	
	
func _on_EnemyStats_enemy_died():
	Utils.instance_scene_on_main(EnemyDeathEffect, global_position)
	anim.play("Pop", -1, 1.2)
	SaverAndLoader.custom_data[id] = true
	
