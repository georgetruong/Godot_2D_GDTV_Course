extends Control

func _ready():
	AudioPlayer.play_win_music()

func _on_button_pressed():
	AudioPlayer.play_bg_music()
	get_tree().change_scene_to_file("res://scenes/start_menu.tscn")
