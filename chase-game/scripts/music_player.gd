extends AudioStreamPlayer

func _ready():
	Globals.connect("player_die", self, "queue_free")
	Globals.connect("player_win", self, "queue_free")
