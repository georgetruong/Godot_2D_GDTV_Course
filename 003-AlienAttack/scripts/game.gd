extends Node2D

@onready var player = $Player
@onready var enemy_container = $EnemyContainer

var lives = 3
var score = 0

func _on_deathzone_area_entered(area:Area2D):
	area.die()

func _on_player_took_damage():
	lives -= 1
	if lives == 0:
		print("Game over!")
		player.die()
	else:
		print(lives)

func _on_enemy_spawner_enemy_spawned(enemy_instance):
	enemy_instance.connect("died", _on_enemy_died)
	enemy_container.add_child(enemy_instance)

func _on_enemy_died():
	score += 100
	print("Score: " + str(score))
