extends Sprite

export(float) var gravity_accel = 400.0
export(float) var jump_force = 200.0

onready var camera = get_node("../Camera2D")

var velocity = Vector2.ZERO

func _ready():
	velocity.y = -jump_force

func _process(delta):
	velocity.y += gravity_accel * delta
	position.y += velocity.y * delta
	if global_position.y > camera.global_position.y + get_viewport_rect().size.y:
		Globals.goto_death_screen()
