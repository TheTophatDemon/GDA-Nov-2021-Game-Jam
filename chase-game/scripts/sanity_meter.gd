extends Label

func _ready():
	Globals.connect("sanity_change", self, "_update_sanity_meter")

func _update_sanity_meter(new_sanity):
	text = "Sanity: %d%%" % new_sanity
