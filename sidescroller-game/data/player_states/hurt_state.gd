class_name HurtState
extends State

@export var player : Player 

func Enter():
	player.player_sprite.play("hurt")


func Exit():
	pass
