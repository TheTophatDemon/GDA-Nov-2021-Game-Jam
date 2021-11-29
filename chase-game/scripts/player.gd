extends "res://scripts/actor.gd"

const SHADOW_SCN = preload("res://objects/flying_shadow.tscn")
const DEAD_SCN = preload("res://objects/dead_player.tscn")

export(float) var sanityDropRate = 25.0

onready var kill_detector = $KillDetector

var sanity = 100.0
var touching_enemies = 0 
var active = false

func _ready():
	var err
	err = Globals.connect("start_game", self, "_on_game_start")
	err = Globals.connect("coin_collected", self, "_on_coin_collected")
	$ShadowSprite.visible = false
	err = kill_detector.connect("area_entered", self, "_on_kill_area_enter")
	err = kill_detector.connect("body_entered", self, "_on_enemy_enter")
	err = kill_detector.connect("body_exited", self, "_on_enemy_exit")
	if err != OK:
		print("Signal error.")

func _on_kill_area_enter(other_area):
	if (other_area.collision_layer & 32) > 0:
		die()
		
func _on_enemy_enter(body):
	if (body.collision_layer & 4) > 0:
		touching_enemies += 1

func _on_enemy_exit(body):
	if (body.collision_layer & 4) > 0:
		touching_enemies -= 1

func die():
	var corpse = DEAD_SCN.instance()
	get_parent().add_child(corpse)
	corpse.global_position = global_position
	queue_free()

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
		
	if touching_enemies > 0:
		sanity -= delta * sanityDropRate
		Globals.emit_signal("sanity_change", sanity)
	if sanity <= 0.0:
		die()
