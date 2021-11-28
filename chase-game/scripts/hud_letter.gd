extends TextureRect

export(Globals.CoinType) var type

func _ready():
	Globals.connect("coin_collected", self, "_on_coin_collected")
	visible = false
	modulate.a = 0.0
	
func _on_coin_collected(coin_type):
	if coin_type == type:
		visible = true
		
func _process(delta):
	if visible:
		modulate.a += delta * 2.0
