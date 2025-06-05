class_name Arrow
extends Area2D


func _process(delta: float) -> void:
	position.x -= get_parent().cam_speed * 1.5 
