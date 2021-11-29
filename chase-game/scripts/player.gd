extends "res://scripts/actor.gd"

const SHADOW_SCN = preload("res://objects/flying_shadow.tscn")

var active = false

func _ready():
	Globals.connect("start_game", self, "_on_game_start")
	Globals.connect("coin_collected", self, "_on_coin_collected")

func _spawn_shadow():
	var shadow = SHADOW_SCN.instance()
	get_parent().add_child(shadow)
	shadow.global_position = $ShadowSprite.global_position
	$ShadowSprite/AnimationPlayer.stop()

func _on_game_start():
	active = true
	
func _on_coin_collected(coin_type):
	get_tree().paused = true
	$ShadowSprite/AnimationPlayer.play("emerge")
	yield($ShadowSprite/AnimationPlayer, "animation_finished")
	get_tree().paused = false

func _process(delta):
	if active:
		var input_x = (1.0 if Input.is_action_pressed("move_right") else 0.0) + (-1.0 if Input.is_action_pressed("move_left") else 0.0)
		control(input_x, Input.is_action_pressed("jump"))
	else:
		control(0.0, false)
