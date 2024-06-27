extends Node

var hurt = preload("res://assets/audio/hurt.wav")
var jump = preload("res://assets/audio/jump.wav")
var mute_all: bool = true
var sfx_volume_db = 0

func _ready():
	$MusicPlayer.volume_db = -100
	sfx_volume_db = -100

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
	asp.volume_db = sfx_volume_db
	asp.play()
	await asp.finished
	asp.queue_free()

func toggle_mute():
	mute_all = !mute_all
	if mute_all:
		$MusicPlayer.volume_db = -100
		sfx_volume_db = -100
	else:
		$MusicPlayer.volume_db = 0
		sfx_volume_db = 0