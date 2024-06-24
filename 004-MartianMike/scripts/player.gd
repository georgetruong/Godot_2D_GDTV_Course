extends CharacterBody2D

@export var gravity = 400
@export var jump_force = 12500
@export var speed = 7500

@onready var animated_sprite = $AnimatedSprite2D

func _process(delta):
	pass

func _physics_process(delta):
	if !is_on_floor():
		velocity.y += gravity * delta
		if velocity.y > 500:
			velocity.y = 500

	if Input.is_action_just_pressed("jump"):
		velocity.y = -jump_force * delta

	var direction = Input.get_axis("move_left", "move_right")
	velocity.x = direction * speed * delta

	move_and_slide()