extends Node2D

var enemy_scene = preload("res://scenes/enemy.tscn")

@onready var timer = $Timer
@onready var spawn_positions = $SpawnPositions

func _ready():
    timer.connect("timeout", _on_timeout)

func _on_timeout():
    spawn_enemy()

func spawn_enemy():
    var spawn_positions_array = spawn_positions.get_children()
    var random_spawn_position = spawn_positions_array.pick_random() 

    var enemy_instance = enemy_scene.instantiate()
    enemy_instance.global_position = random_spawn_position.global_position
    add_child(enemy_instance)