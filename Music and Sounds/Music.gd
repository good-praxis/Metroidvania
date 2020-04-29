extends Node

export(Resource) var music_list = null setget set_music_list

var music_list_index: = 0
var fade_in_process: = false
var normal_db: = 0 setget set_volume
var working_db: = 0 
var quiet_db: = -80

onready var musicPlayer: = $AudioStreamPlayer
onready var tween: = $Tween

func _ready():
	normal_db = musicPlayer.volume_db
	working_db = normal_db + music_list.volume_db_modifier

func set_music_list(value):
	music_list_index = 0
	working_db = normal_db + value.volume_db_modifier
	music_list = value

func set_volume(volume):
	normal_db = volume
	working_db = normal_db + music_list.volume_db_modifier
	musicPlayer.volume_db = working_db
	
func adjust_volume(diff):
	self.normal_db = normal_db + diff

func list_play():
	assert(music_list.list.size() > 0)
	musicPlayer.stream = music_list.list[music_list_index]
	musicPlayer.play()
	music_list_index += 1
	if music_list_index == music_list.list.size():
		music_list_index = 0


func list_stop():
	musicPlayer.stop()
	
func fade_out(duration = 5.0):
	if not fade_in_process:
		fade_in_process = true
		tween.interpolate_property(musicPlayer, "volume_db", working_db, quiet_db, duration,Tween.TRANS_SINE, Tween.EASE_IN)
		tween.start()
		
func fade_in(duration = 3.0):
	if not fade_in_process:
		fade_in_process = true
		musicPlayer.volume_db = quiet_db
		list_play()
		tween.interpolate_property(musicPlayer, "volume_db", quiet_db, working_db, duration,Tween.TRANS_SINE, Tween.EASE_IN)
		tween.start()


func _on_AudioStreamPlayer_finished():
	list_play()


func _on_Tween_tween_completed(object, _key):
	fade_in_process = false
	if object.volume_db == quiet_db:
		object.stop()
		music_list_index = 0
