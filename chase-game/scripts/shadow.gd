extends "res://scripts/actor.gd"

onready var nav = get_node("../Navigation2D") as Navigation2D
onready var target = get_node("../Player") as Node2D
onready var nav_line = $NavLine

func _ready():
	remove_child(nav_line)
	get_parent().add_child(nav_line)
	nav_line.global_position = Vector2.ZERO

func _process(delta):
	yield(get_tree().create_timer(1.0), "timeout") #Give the player a bit to get a head start
	
	if is_instance_valid(target):
		var path = nav.get_simple_path(global_position, target.global_position, true)
		nav_line.points = path
		
		if path.size() > 1:
			var horz_delta = 0.0
			var path_index = 0 #The point in the path determining the direction to move in
			for i in range(path.size()):
				path_index = i
				horz_delta = path[path_index].x - global_position.x
				if abs(horz_delta) > 0.5: break
			control(sign(horz_delta), path[path_index].y < global_position.y - 14.0)
		else:
			control(0.0, false)
