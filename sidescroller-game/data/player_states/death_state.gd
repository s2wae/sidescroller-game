class_name DeathState
extends State

@export var player : Player 

func Enter():
	player.player_sprite.play("duck")


func Exit():
	pass

func Update(_delta: float) -> void:
	player.velocity.y += player.GRAVITY * _delta
