class_name Player
extends CharacterBody2D

const JUMP_SPEED : float = -280
const DUCK_SPEED : float = 300
const GRAVITY : float = 1000

@export var player_sprite : AnimatedSprite2D
@export var player_col : CollisionShape2D
@export var hurt_box : Area2D
@export var fsm : FiniteStateMachine
@export var hud : Control

var lives_label : Label
var current_lives : int = 3

func _ready() -> void:
	lives_label = hud.get_node("Lives")
	lives_label.text = "Lives: " + str(current_lives)
	hurt_box.area_entered.connect(_on_hurt_box_area_entered)

func _physics_process(delta: float) -> void:
	move_and_slide()


func _on_hurt_box_area_entered(area: Area2D) -> void:

	current_lives = current_lives - 1
	if area.is_in_group("obstacle"):
		lives_label.text = "Lives: " + str(current_lives)

	if current_lives <= 0:
		current_lives = 0
		lives_label.text = "Lives: " + str(current_lives)
		fsm.force_change_state("death")
