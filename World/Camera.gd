extends Camera2D

var MainInstances: MainInstances = ResourceLoader.MainInstances

var shake: = 0.0
var toggled := false

onready var timer: = $Timer

func _ready():
# warning-ignore-all:return_value_discarded
	Events.connect("add_screenshake", self, "_on_Events_add_screenshake")
	Events.connect("screenshake_on", self, "_on_Events_screenshake_on")
	Events.connect("screenshake_off", self, "_on_Events_screenshake_off")
	MainInstances.WorldCamera = self

func _exit_tree():
	if MainInstances.WorldCamera == self:
		MainInstances.WorldCamera = null


func _process(_delta):
	offset_h = rand_range(-shake, shake)
	offset_v = rand_range(-shake, shake)

func screenshake(amount, duration) -> void:
	shake = amount
	timer.wait_time = duration
	timer.start()


func _on_Timer_timeout():
	if not toggled:
		shake = 0
	
func _on_Events_add_screenshake(amount, duration):
	screenshake(amount, duration)

func _on_Events_screenshake_on(amount):
	shake = amount
	
func _on_Events_screenshake_off():
	shake = 0
