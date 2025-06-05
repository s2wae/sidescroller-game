class_name RunState
extends State

@export var player : Player 

func Enter():
	player.player_sprite.play("run")


func Exit():
	pass
