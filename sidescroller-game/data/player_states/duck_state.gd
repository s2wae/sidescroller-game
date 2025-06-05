class_name DuckState
extends State

@export var player : Player 

func Enter():
	player.player_sprite.play("duck")


func Exit():
	pass
