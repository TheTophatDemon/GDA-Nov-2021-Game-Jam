extends AudioStreamPlayer

func _ready():
	Globals.connect("player_die", self, "queue_free")
