extends Node

var hurt = preload("res://assets/audio/hurt.wav")
var jump = preload("res://assets/audio/jump.wav")
var mute_all: bool = false
var master_volume_db = 0

func _ready():
	$MusicPlayer.volume_db = 0
	master_volume_db = 0

func play_sfx(sfx_name: String):
	var stream = null 
	if sfx_name == "hurt":
		stream = hurt
	elif sfx_name == "jump":
		stream = jump
	else:
		print_debug("Invalid SFX name")
		return

	var asp = AudioStreamPlayer.new()
	asp.name = "SFX"
	asp.stream = stream
	add_child(asp)
	asp.volume_db = master_volume_db
	asp.play()
	await asp.finished
	asp.queue_free()

func toggle_mute():
	mute_all = !mute_all
	if mute_all:
		$MusicPlayer.volume_db = -100
		master_volume_db = -100
	else:
		$MusicPlayer.volume_db = 0
		master_volume_db = 0

func play_win_music():
	play_music(load("res://assets/audio/music/Escaping.WAV"))

func play_bg_music():
	play_music(load("res://assets/audio/music/MUSIC.WAV"))

func play_music(stream):
	if stream:
		$MusicPlayer.stop()
		$MusicPlayer.volume_db = master_volume_db
		$MusicPlayer.stream = stream
		$MusicPlayer.play()
	else:
		print("Invalid music file")
	