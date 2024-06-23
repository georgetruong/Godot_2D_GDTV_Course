extends CharacterBody2D

var speed = 300

func _physics_process(delta):
	velocity = Vector2(0, 0)

	if Input.is_action_pressed("move_right"):
		velocity.x = speed
	if Input.is_action_pressed("move_left"):
		velocity.x = -speed
	if Input.is_action_pressed("move_up"):
		velocity.y = -speed
	if Input.is_action_pressed("move_down"):
		velocity.y = speed

	move_and_slide()

	# Prevent player from moving beyond the screen
	global_position = global_position.clamp(Vector2(0, 0), get_viewport_rect().size)