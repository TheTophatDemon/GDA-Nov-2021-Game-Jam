extends TextureRect

export(float) var sensitivity = 1.0

var old_sanity:float = 100.0
var sanity:float = 100.0

var min_alpha:float = 0.0

func _ready():
	Globals.connect("sanity_change", self, "_update_sanity")
	modulate.a = 0.0

func _update_sanity(new_sanity):
	sanity = new_sanity
	if sanity < 25.0:
		min_alpha = 0.25
	
func _process(delta):
	rect_size = get_viewport_rect().size
	if old_sanity > sanity:
		modulate.a += sensitivity * delta
	else:
		modulate.a = max(min_alpha, modulate.a - sensitivity * delta)
	old_sanity = sanity
