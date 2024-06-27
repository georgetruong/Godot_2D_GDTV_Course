extends Node2D

@export var next_level: PackedScene = null
@export var is_final_level: bool = false

@onready var start = $Start
@onready var exit = $Exit
@onready var death_zone = $Deathzone

@onready var ui_layer = $UILayer
@onready var hud = $UILayer/HUD

var player = null

@export var level_time = 5
var timer_node = null
var time_left

var win = false

func _ready():
	# Move player to starting position
	player = get_tree().get_first_node_in_group("player")
	if player:
		player.global_position = start.get_spawn_position()

	# Setup traps to reset player when touched
	var traps = get_tree().get_nodes_in_group("traps")
	for trap in traps:
		#trap.connect("touched_player", _on_trap_touched_player)
		trap.touched_player.connect(_on_trap_touched_player) 

	exit.body_entered.connect(_on_exit_body_entered)
	death_zone.body_entered.connect(_on_deathzone_body_entered)

	time_left = level_time
	hud.set_time_label(time_left)

	# Setup and start level timer
	timer_node = Timer.new()
	timer_node.name = "LevelTimer"
	timer_node.wait_time = 1
	timer_node.timeout.connect(_on_level_timer_timeout)
	add_child(timer_node)
	timer_node.start()

func _process(delta):
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	elif Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()

func _on_deathzone_body_entered(body:Node2D):
	reset_player()

func _on_trap_touched_player():
	reset_player()

func reset_player():
	AudioPlayer.play_sfx("hurt")
	player.velocity = Vector2.ZERO
	player.global_position = start.get_spawn_position()

func _on_exit_body_entered(body):
	if body is Player:
		if is_final_level || (next_level != null):
			player.active = false
			exit.animate()
			win = true
			await get_tree().create_timer(1.5).timeout
			if is_final_level:
				ui_layer.show_win_screen(true)	
			else:
				get_tree().change_scene_to_packed(next_level)

func _on_level_timer_timeout():
	if !win:
		time_left -= 1
		hud.set_time_label(time_left)
		if time_left <= 0:
			hud.set_time_label(0)
			timer_node.stop()

			player.active = false
			ui_layer.show_lose_screen(true)
