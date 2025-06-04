class_name Arrow
extends Area2D

func _on_body_entered(body: Node2D) -> void:
	print('TEST')

func _process(delta: float) -> void:
	position.x -= get_parent().cam_speed * 1.5 
