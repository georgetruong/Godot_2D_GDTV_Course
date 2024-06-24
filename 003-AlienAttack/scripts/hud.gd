extends Control

@onready var score = $Score
@onready var lives_left = $LivesLeft

func set_score_label(new_score):
	score.text = "SCORE: " + str(new_score)

func set_lives_left_label(new_lives):
	lives_left.text = "X " + str(new_lives)