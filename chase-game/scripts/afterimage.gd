extends Sprite

export(float) var fade_rate = 2.0

func _process(delta):
	modulate.a -= delta * fade_rate
	if modulate.a <= 0.0:
		queue_free()
