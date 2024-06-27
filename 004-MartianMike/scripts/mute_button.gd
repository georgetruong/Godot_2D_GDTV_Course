extends Button

func _ready():
	toggle_text()

func toggle_text():
	if AudioPlayer.mute_all:
		self.text = "UNMUTE"
	else:
		self.text = "MUTE"

func _on_mute_button_pressed():
	self.focus_mode = Control.FOCUS_NONE
	AudioPlayer.toggle_mute()
	toggle_text()
