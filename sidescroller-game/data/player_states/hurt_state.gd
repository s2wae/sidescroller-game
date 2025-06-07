class_name HurtState
extends State

@export var player : Player
@export var player_sprite : AnimatedSprite2D
@export var hurt_box_col : CollisionShape2D
@export var hurt_timer : Timer

func Enter():
	hurt_box_col.disabled = true
	player_sprite.play("hurt")
	hurt_timer.start()
	hurt_timer.timeout.connect(_on_hurt_timer_timeout)


func Exit():
	hurt_box_col.disabled = false


func _on_hurt_timer_timeout() -> void:
	print("TIMEOUT")
	state_transition.emit(self, "run")


func Update(_delta: float) -> void:
	player.velocity.y += player.GRAVITY * _delta
