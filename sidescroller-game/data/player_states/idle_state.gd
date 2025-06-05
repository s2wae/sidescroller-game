class_name IdleState
extends State

@export var player : Player 

func Enter():
	player.player_sprite.play("idle")


func Exit():
	pass
