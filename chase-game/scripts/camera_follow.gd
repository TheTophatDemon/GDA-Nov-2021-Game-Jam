extends Camera2D

export(NodePath) var target_path

func _process(delta):
	var target = get_node_or_null(target_path)
	if target != null:
		global_position = target.global_position
