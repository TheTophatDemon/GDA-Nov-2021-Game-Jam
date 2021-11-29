extends Control

export(float) var restart_time = 4.0

var restart_timer = 0.0

func _process(delta):
	restart_timer += delta
	if restart_timer > restart_time:
		Globals.restart_game()
