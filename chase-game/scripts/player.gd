extends "res://scripts/actor.gd"

func _process(delta):
	var input_x = (1.0 if Input.is_action_pressed("move_right") else 0.0) + (-1.0 if Input.is_action_pressed("move_left") else 0.0)
	control(input_x, Input.is_action_pressed("jump"))
