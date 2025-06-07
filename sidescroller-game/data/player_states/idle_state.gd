class_name IdleState
extends State

@export var player : Player 

func Enter():
	player.player_sprite.play("idle")


func Exit():
	pass


func Update(_delta: float) -> void:
	player.velocity.y += player.GRAVITY * _delta
	if Input.is_action_pressed("start"):
		state_transition.emit(self, "run")
