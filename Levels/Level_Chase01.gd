extends "res://Levels/Level.gd"

var fade_out_triggered := false
var boss_triggered := false

const ChaseMusicList = preload("res://Music and Sounds/MusicLists/ChaseMusicList.tres")

onready var boss := $BossEnemy

func _ready():
	boss.awake = false

func _on_FadeOutTrigger_area_triggered():
	if not fade_out_triggered:
		fade_out_triggered = true
		Music.fade_out()


func _on_BossTrigger_area_triggered():
	if not boss_triggered:
		Music.music_list = ChaseMusicList
		Music.fade_in(.01)
		SoundFx.play("Gurgle", 0.5, 5)
		Events.emit_signal("screenshake_on", .1)
		boss.awake = true
		boss.animationPlayer.playback_speed = 2
