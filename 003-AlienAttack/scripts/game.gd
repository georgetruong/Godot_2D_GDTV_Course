extends Node2D

@onready var player = $Player
@onready var enemy_container = $EnemyContainer
@onready var hud = $UI/HUD

var lives = 3
var score = 0

func _ready():
	hud.set_score_label(score)
	hud.set_lives_left_label(lives)

func _on_deathzone_area_entered(area:Area2D):
	area.die()

func _on_player_took_damage():
	lives -= 1
	hud.set_lives_left_label(lives)
	if lives == 0:
		print("Game over!")
		player.die()

func _on_enemy_spawner_enemy_spawned(enemy_instance):
	enemy_instance.connect("died", _on_enemy_died)
	enemy_container.add_child(enemy_instance)

func _on_enemy_died():
	score += 100
	hud.set_score_label(score)

func _on_enemy_spawner_path_enemy_spawned(path_enemy_instance):
	enemy_container.add_child(path_enemy_instance)
	path_enemy_instance.enemy.connect("died", _on_enemy_died)