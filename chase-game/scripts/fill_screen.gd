extends Control

func _ready():
	visible = true

func _process(delta):
	rect_size = get_viewport_rect().size
	rect_position = -rect_size / 2
