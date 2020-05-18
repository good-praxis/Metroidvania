extends Node

var MainInstances: MainInstances = ResourceLoader.MainInstances
var PlayerStats: PlayerStats = ResourceLoader.PlayerStats

export(bool) var gun_broken = false
export(bool) var double_jump_unlocked = true


func _ready():
	MainInstances.DebugHelper = self


