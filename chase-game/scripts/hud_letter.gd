extends TextureRect

export(Globals.CoinType) var type

var collected = false

func _ready():
	Globals.connect("coin_collected", self, "_on_coin_collected")
	modulate.a = 0.0
	
func _on_coin_collected(coin_type):
	if coin_type == type:
		collected = true
		
func _process(delta):
	if collected:
		modulate.a += delta * 2.0
