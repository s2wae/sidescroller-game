class_name Player
extends CharacterBody2D

const JUMP_SPEED : float = -280
const DUCK_SPEED : float = 300
const GRAVITY : float = 1000

@export var player_sprite : AnimatedSprite2D
@export var run_col : CollisionShape2D
@export var duck_col : CollisionShape2D
@export var run_area : Area2D
@export var duck_area : Area2D

var is_hurt : bool = false

func _physics_process(delta: float) -> void:
	if is_hurt == false:
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

# TODO also try to fix this 
func _on_running_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("obstacle"):
		is_hurt = true
		print("HELP")
		player_sprite.play("hurt")
		await get_tree().create_timer(.5).timeout
	is_hurt = false
