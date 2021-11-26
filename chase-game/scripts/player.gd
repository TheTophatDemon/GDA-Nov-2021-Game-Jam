extends "res://scripts/actor.gd"

const SHADOW_SCN = preload("res://objects/shadow.tscn")

var active = false

func _ready():
	Globals.connect("start_game", self, "_on_game_start")

func _spawn_shadow():
	var shadow = SHADOW_SCN.instance()
	get_parent().add_child(shadow)
	shadow.global_position = $ShadowSprite.global_position
	$ShadowSprite.queue_free()

func _on_game_start():
	active = true

func _process(delta):
	if active:
		var input_x = (1.0 if Input.is_action_pressed("move_right") else 0.0) + (-1.0 if Input.is_action_pressed("move_left") else 0.0)
		control(input_x, Input.is_action_pressed("jump"))
	else:
		control(0.0, false)
