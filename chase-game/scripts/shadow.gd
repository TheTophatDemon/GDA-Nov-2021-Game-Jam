extends "res://scripts/actor.gd"

onready var nav = get_node("../Navigation2D") as Navigation2D
onready var target = get_node("../Player") as Node2D
onready var nav_line = $NavLine

func _ready():
	remove_child(nav_line)
	get_parent().add_child(nav_line)
	nav_line.global_position = Vector2.ZERO

func _process(delta):
	yield(get_tree().create_timer(2.0), "timeout") #Give the player a couple of seconds to get a head start
	
	if is_instance_valid(target):
		var path = nav.get_simple_path(global_position, target.global_position, true)
		nav_line.points = path
		
		if path.size() > 1:
			var horz_delta = sign(path[1].x - global_position.x)
			control(horz_delta, path[1].y < global_position.y - 14.0)
		else:
			control(0.0, false)
