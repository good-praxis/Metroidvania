extends Powerup

func _ready():
	if PlayerStats.double_jump_unlocked:
		queue_free()

func _pickup():
	._pickup()
	PlayerStats.double_jump_unlocked = true
	queue_free()
