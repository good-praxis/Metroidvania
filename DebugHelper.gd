extends Node

var MainInstances: MainInstances = ResourceLoader.MainInstances
var PlayerStats: PlayerStats = ResourceLoader.PlayerStats

export(bool) var enabled = false
export(bool) var gun_broken = false
export(bool) var double_jump_unlocked = true

export(bool) var music_mute = false setget set_music_mute
export(bool) var sfx_mute = false setget set_sfx_mute

func _ready():
	if not enabled:
		info("Not enabled")
		return
	
	MainInstances.DebugHelper = self
	info("Mounted")

func set_music_mute(muted):
	Music.muted = muted
	info("Music %s" % "muted" if muted else "unmuted")
			
func set_sfx_mute(muted):
	SoundFx.muted = muted
	info("SoundFx %s" % "muted" if muted else "unmuted")
	

# Debug function that configures the player
func prime_player():
	PlayerStats.gun_broken = gun_broken
	PlayerStats.double_jump_unlocked = double_jump_unlocked
	info("PlayerStats primed")
	
func info(string):
	return print("DebugHelper: ", string)

