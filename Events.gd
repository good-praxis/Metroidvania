extends Node

# warning-ignore-all:unused_signal
signal add_screenshake(amount, duration)
signal screenshake_on(amount)
signal screenshake_off()

signal screen_fade_out(playback_speed)
signal screen_fade_in(playback_speed)

var is_fading: = false
