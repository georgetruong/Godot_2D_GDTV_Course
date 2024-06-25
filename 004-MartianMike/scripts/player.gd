extends CharacterBody2D
class_name Player

var current_jumps = 0
var max_jumps = 2
var active = true

@export var gravity = 400
@export var jump_force = 200
@export var speed = 7500

@onready var animated_sprite = $AnimatedSprite2D

func _process(delta):
	pass

func _physics_process(delta):
	if !is_on_floor():
		velocity.y += gravity * delta
		if velocity.y > 500:
			velocity.y = 500
	else:
		current_jumps = 0

	var direction = 0
	if active:
		if Input.is_action_just_pressed("jump") && current_jumps < max_jumps: #&& is_on_floor():
			jump(jump_force)

		direction = Input.get_axis("move_left", "move_right")

	velocity.x = direction * speed * delta
	move_and_slide()
	update_animations(direction)

func update_animations(direction):
	if direction != 0:
		animated_sprite.flip_h = (direction == -1)

	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
	else:
		if velocity.y < 0:
			animated_sprite.play("jump")
		else:
			animated_sprite.play("fall")

func jump(force, jump_pad = false):
	velocity.y = -force
	current_jumps += 1
	if jump_pad:
		current_jumps = 1