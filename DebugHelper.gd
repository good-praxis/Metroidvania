extends Node

var MainInstances: MainInstances = ResourceLoader.MainInstances
var PlayerStats: PlayerStats = ResourceLoader.PlayerStats

export(bool) var enabled = false
export(bool) var gun_broken = false
export(bool) var double_jump_unlocked = true


func _ready():
	if not enabled:
		info("Not enabled")
		return
	
	MainInstances.DebugHelper = self
	info("Mounted")

# Debug function that configures the player
func prime_player():
	PlayerStats.gun_broken = gun_broken
	PlayerStats.double_jump_unlocked = double_jump_unlocked
	info("PlayerStats primed")
	
func info(string):
	return print("DebugHelper: ", string)

