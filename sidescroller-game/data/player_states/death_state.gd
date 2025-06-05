class_name DeathState
extends State

@export var player : Player 

func Enter():
	player.player_sprite.play("duck")


func Exit():
	pass
