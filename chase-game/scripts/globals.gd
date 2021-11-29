extends Node

enum CoinType {
	D, O, V, E, R, I, E2
}

signal start_game()

signal coin_collected(coin_type)

func _process(_delta):
	if Input.is_action_just_pressed("mute_music"):
		var mus_idx = AudioServer.get_bus_index("Music")
		AudioServer.set_bus_mute(mus_idx, not AudioServer.is_bus_mute(mus_idx))
