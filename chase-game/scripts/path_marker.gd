extends Sprite

export(NodePath) var target_path

var target:Node2D

onready var nav = get_parent() as Navigation2D

func _ready():
	target = get_node(target_path) as Node2D

func _process(_delta):
	if target != null:
		global_position = nav.get_closest_point(target.global_position)
