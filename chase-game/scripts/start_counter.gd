extends Label



func _ready():
	$AnimationPlayer.play("countdown")
	$AnimationPlayer.connect("animation_finished", self, "_on_animation_finished")

func _on_animation_finished(anim):
	Globals.emit_signal("start_game")
