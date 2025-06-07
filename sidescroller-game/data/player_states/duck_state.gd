class_name DuckState
extends State

@export var player : Player 

func Enter():
	player.player_sprite.play("duck")


func Exit():
	pass


func Update(_delta: float) -> void:
	player.velocity.y += player.GRAVITY * _delta
	player.velocity.y += player.DUCK_SPEED
	if Input.is_action_just_released("duck"):
		state_transition.emit(self, "run")
