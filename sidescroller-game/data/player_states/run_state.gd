class_name RunState
extends State

@export var player : Player 
@export var hurt_box : Area2D

func Enter():
	player.player_sprite.play("run")
	hurt_box.area_entered.connect(_on_hurt_box_entered)


func Exit():
	pass


func Update(_delta: float) -> void:
	player.velocity.y += player.GRAVITY * _delta
	if player.is_on_floor():
		if Input.is_action_pressed("jump"):
			player.velocity.y = player.JUMP_SPEED
			
	if Input.is_action_pressed("duck"):
		state_transition.emit(self, "duck")


func _on_hurt_box_entered(area: Area2D) -> void:
	state_transition.emit(self,"hurt")
