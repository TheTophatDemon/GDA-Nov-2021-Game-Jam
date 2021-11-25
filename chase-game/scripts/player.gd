extends KinematicBody2D

export(float) var gravity_accel = 400.0
export(float) var max_fall = 400.0
export(float) var jump_force = 200.0
export(float) var jump_accel = 200.0
export(float) var friction = 300.0
export(float) var run_speed = 200.0
export(float) var run_accel = 500.0
export(float) var wall_jump_force = 100.0

onready var floor_trigger = $FloorTrigger
#onready var slide_trigger = $SlideTrigger
onready var slide_cast = $SlideCast
onready var slide_cast_2 = $SlideCast2

var velocity = Vector2()
var facing_right = true
var jumping = false
var sliding = false

var moving = false
var on_ground = false
#var can_slide = false

func _ready():
	var err = floor_trigger.connect("body_entered", self, "_on_sensor_enter", [floor_trigger])
	err = floor_trigger.connect("body_exited", self, "_on_sensor_exit", [floor_trigger])
	#err = slide_trigger.connect("body_entered", self, "_on_sensor_enter", [slide_trigger])
	#err = slide_trigger.connect("body_exited", self, "_on_sensor_exit", [slide_trigger])
	if err:
		print("Signal fail")

func _on_sensor_enter(body, sensor):
	if (body.collision_layer & 2) > 0:
		if sensor == floor_trigger:
			on_ground = true
		#elif sensor == slide_trigger:
			#can_slide = true

func _on_sensor_exit(body, sensor):
	if (body.collision_layer & 2) > 0:
		if sensor == floor_trigger:
			on_ground = false
		#elif sensor == slide_trigger:
			#can_slide = false
	
func _process(delta):
	if Input.is_action_pressed("move_right"):
		velocity.x += run_accel * delta
		facing_right = true
		slide_cast.cast_to.x = abs(slide_cast.cast_to.x)
		slide_cast_2.cast_to.x = abs(slide_cast.cast_to.x)
		moving = true
	elif Input.is_action_pressed("move_left"):
		velocity.x -= run_accel * delta
		facing_right = false
		slide_cast.cast_to.x = -abs(slide_cast.cast_to.x)
		slide_cast_2.cast_to.x = -abs(slide_cast.cast_to.x)
		moving = true
	else:
		moving = false
	velocity.x = clamp(velocity.x, -run_speed, run_speed)
	
	var slide_factor = 1.0
	if slide_cast.is_colliding() and slide_cast_2.is_colliding() and !on_ground:
		slide_factor = 0.25
		sliding = true
	else:
		sliding = false
	
	#Gravity falling
	velocity.y = min(max_fall, velocity.y + gravity_accel * slide_factor * delta)
	if on_ground:
		#Friction
		velocity.x -= min(abs(velocity.x), friction * delta) * sign(velocity.x)
		velocity.y = 0.0
	
	#Jumping
	if (on_ground or sliding) and Input.is_action_pressed("jump"):
		jumping = true
		velocity.y = -jump_force
		if sliding:
			velocity.x = wall_jump_force * slide_cast.get_collision_normal().x
	if jumping:
		if Input.is_action_pressed("jump") and velocity.y <= 0.0:
			velocity.y -= jump_accel * delta
		else:
			jumping = false
	velocity = move_and_slide_with_snap(velocity, Vector2(0.0, -1.0), Vector2.UP, true)
