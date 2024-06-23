extends Node2D


func _on_deathzone_area_entered(area:Area2D):
	area.die()
