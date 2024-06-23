extends Area2D

signal died

@export var speed = 200

func _physics_process(delta):
	global_position.x += (speed * delta * -1)

func die():
	emit_signal("died")
	queue_free()

func _on_body_entered(body:Node2D):
	body.take_damage()
	die()
