extends Control

export(float) var exit_time = 16.0

var timer = 0.0

func _ready():
	$AnimationPlayer.play("cutscene")

func _process(delta):
	timer += delta
	if timer > exit_time:
		Globals.restart_game()
