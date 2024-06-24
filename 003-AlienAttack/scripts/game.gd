extends Node2D

var lives = 3
var score = 0

var gos_scene = preload("res://scenes/game_over_screen.tscn")

@onready var player = $Player
@onready var enemy_container = $EnemyContainer
@onready var hud = $UI/HUD

@onready var enemy_hit_sound = $EnemyHitSound
@onready var player_hit_sound = $PlayerHitSound

func _ready():
	hud.set_score_label(score)
	hud.set_lives_left_label(lives)

func _on_deathzone_area_entered(area:Area2D):
	# enemy enters deathzone to the left of screen
	area.queue_free()

func _on_player_took_damage():
	lives -= 1
	hud.set_lives_left_label(lives)
	player_hit_sound.play()
	if lives == 0:
		player.die()
		hud.hide()
		await get_tree().create_timer(1).timeout
		show_game_over_screen()

func show_game_over_screen():
	var gos = gos_scene.instantiate()
	gos.set_score_label(score)
	$UI.add_child(gos)

func _on_enemy_spawner_enemy_spawned(enemy_instance):
	enemy_instance.connect("died", _on_enemy_died)
	enemy_container.add_child(enemy_instance)

func _on_enemy_died():
	score += 100
	hud.set_score_label(score)
	enemy_hit_sound.play()
