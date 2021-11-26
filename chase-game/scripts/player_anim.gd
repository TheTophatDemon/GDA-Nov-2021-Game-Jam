extends AnimationPlayer

export(float) var run_velocity = 150.0
export(float) var fall_threshold = 10.0
export(float) var skid_velocity = 75.0

onready var player = get_node("..")
onready var sprite = get_node("../Sprite")

func _ready():
	var err = connect("animation_changed", self, "_on_anim_change")
	if err:
		print("Signal fail")

func _process(delta):
	if player.sliding:
		play("slide")
	else:
		if player.on_ground:
			if !player.moving:
				if abs(player.velocity.x) > skid_velocity:
					play("skid")
				else:
					play("idle")
			elif abs(player.velocity.x) < run_velocity:
				play("walk", -1, abs(player.velocity.x) / run_velocity)
			else:
				play("run")
		elif player.velocity.y < 0.0:
			play("jump")
		else:
			play("fall")
	
	sprite.flip_h = not player.facing_right

func _on_anim_change(new_anim:String):
	print(new_anim)
