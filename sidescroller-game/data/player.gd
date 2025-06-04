class_name Player
extends CharacterBody2D

const JUMP_SPEED : float = -280
const DUCK_SPEED : float = 150
const GRAVITY : float = 1000

@export var player_sprite : AnimatedSprite2D
@export var run_col : CollisionShape2D
@export var duck_col : CollisionShape2D


func _physics_process(delta: float) -> void:
	velocity.y += GRAVITY * delta
	
	if Input.is_action_pressed("duck"):
		player_sprite.play("duck")
		run_col.disabled = true
		velocity.y = DUCK_SPEED
	
	if is_on_floor():
		if Input.is_action_pressed("jump"):
			velocity.y = JUMP_SPEED
		elif Input.is_action_pressed("duck"):
			player_sprite.play("duck")
			run_col.disabled = true
		else:
			player_sprite.play("run")
			run_col.disabled = false
	
	move_and_slide()
	
