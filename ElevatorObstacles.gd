extends TileMap

onready var EffectsCollection = $EffectCollection

var PlayerStats = ResourceLoader.PlayerStats
var MainInstances = ResourceLoader.MainInstances

const SilentEnemyDeathEffect = preload("res://Effects/SilentEnemyDeathEffect.tscn")

signal hit

func _on_Area2D_body_entered(_body):
	visible = false
	PlayerStats.connected_to_events = false
	var player = MainInstances.Player
	player._on_Hurtbox_hit(1)
	#PlayerStats.health -= 1
	for position in EffectsCollection.get_children():
		Utils.instance_scene_on_main(SilentEnemyDeathEffect, position.position + global_position)
	
	SoundFx.play("EnemyDie")
	PlayerStats.connected_to_events = true
	
	emit_signal("hit")
	
	queue_free()
