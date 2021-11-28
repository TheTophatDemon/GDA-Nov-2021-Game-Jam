extends Node2D

export(Globals.CoinType) var coin_type

onready var area:Area2D = $Area2D
onready var anim_player = $AnimationPlayer

func _ready():
	area.connect("body_entered", self, "_on_body_enter")
	anim_player.connect("animation_finished", self, "_on_anim_finish")
	anim_player.play("float")
	
func _on_body_enter(body):
	if body.collision_layer & 5:
		anim_player.play("collect")
		Globals.emit_signal("coin_collected", coin_type)
		$CollectSound.play()
		
func _on_anim_finish(anim):
	if anim == "collect":
		queue_free()
