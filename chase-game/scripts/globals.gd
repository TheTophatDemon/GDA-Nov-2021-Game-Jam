extends Node

enum CoinType {
	D, O, V, E, R, I, E2
}

signal start_game()
signal coin_collected(coin_type)
signal sanity_change(new_sanity)
signal player_die()
signal player_win()

var mus_bus_idx = 0

func _ready():
	mus_bus_idx = AudioServer.get_bus_index("Music")
	AudioServer.set_bus_mute(mus_bus_idx, false)

func _process(_delta):
	if Input.is_action_just_pressed("mute_music"):
		AudioServer.set_bus_mute(mus_bus_idx, not AudioServer.is_bus_mute(mus_bus_idx))
		
func goto_death_screen():
	get_tree().change_scene("res://scenes/lose.tscn")
	
func restart_game():
	get_tree().change_scene("res://scenes/game.tscn")
	
func goto_win_screen():
	get_tree().change_scene("res://scenes/win.tscn")
