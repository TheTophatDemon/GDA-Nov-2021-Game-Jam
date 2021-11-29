extends KinematicBody2D

const AFTERIMAGE_SCN = preload("res://objects/shadow_afterimage.tscn")

export(float) var flySpeed = 200.0
export(float) var flyAccel = 400.0
export(float) var wakeTime = 1.0 #Number of seconds before chasing
export(float) var afterimg_speed = 0.1 #Number of seconds between spawning afterimages

onready var shape = $CollisionShape2D
onready var nav = get_node("../Navigation2D") as Navigation2D
onready var target = get_node("../Player") as Node2D
onready var nav_line = $NavLine
onready var sprite = $Sprite

var path_to_target = PoolVector2Array()
var velocity = Vector2.ZERO
var wake_timer = 0.0
var afterimg_timer = 0.0

func _ready():
	remove_child(nav_line)
	get_parent().add_child(nav_line)
	nav_line.global_position = Vector2.ZERO

func _process(delta):
	wake_timer += delta
	if wake_timer > wakeTime:
		if is_instance_valid(target):
			path_to_target = nav.get_simple_path(global_position, target.global_position, false)
			nav_line.points = path_to_target
			var vec_to_next:Vector2 = path_to_target[1] - global_position
			var dist_to_next = vec_to_next.length()
			var move = (vec_to_next / dist_to_next)
			if move.x < -0.1: sprite.flip_h = true
			if move.x > 0.1: sprite.flip_h = false
			velocity += flyAccel * move * delta
		if velocity.length_squared() > 1.0:
			afterimg_timer += delta
			if afterimg_timer > afterimg_speed:
				afterimg_timer = 0.0
				var afterimg = AFTERIMAGE_SCN.instance()
				get_parent().add_child(afterimg)
				afterimg.global_position = global_position
				afterimg.flip_h = sprite.flip_h
	
	#Speed cap
	var speed = velocity.length()
	if speed > flySpeed: velocity = flySpeed * velocity / speed
	
	move_and_slide(velocity, Vector2.UP)
