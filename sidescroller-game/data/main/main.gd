class_name Main
extends Node2D


@export var camera : Camera2D
@export var player : Player
@export var floor : StaticBody2D
@export var hud : Control

const START_SPEED : int = 10
const MAX_SPEED : int  = 25
const SCORE_MODIFIER : int = 5
const SPEED_MODIFER : int = 1000

var arrow_scene : PackedScene = preload("uid://dwxqqiw8qo5cc")
var rock_scene : PackedScene = preload("uid://ub2whn5wmbhc")


var obstacle_types : Array = [rock_scene]
var current_obstacles : Array = []
var arrow_heights : Array = [325, 310, 295]
var cam_speed : float = .8
var screen_size : Vector2i
var prev_obs
var floor_height : float
var start_game : bool = false
var score : float = 0

func _ready() -> void:
	screen_size = get_window().size
	floor_height = floor.get_node("Front").texture.get_height()


func _process(delta: float) -> void:
	if player.current_lives <= 0:
		start_game = false
	
	if Input.is_action_just_pressed("start"):
		start_game = true
		player.current_lives = 3


	
	if start_game:
		generate_obstacle()
		score += cam_speed
		camera.position.x += cam_speed
		player.position.x += cam_speed
			
		if camera.position.x - floor.position.x > 928 * 1.5:
			floor.position.x += 928
				
		for obstacles in current_obstacles:
			if obstacles.position.x < (camera.position.x - screen_size.x * 0.2):
				delete_obstacle(obstacles)


func generate_obstacle() -> void:
	if current_obstacles.is_empty() or prev_obs.position.x < score + randi_range(300, 500):
		var obs_type : PackedScene = obstacle_types.pick_random()
		var obstacle_instance : Node
		var max_obs : int = 3
		for i in range(randi() % max_obs + 1):
			obstacle_instance = obs_type.instantiate()
			var obs_height : float = obstacle_instance.get_node("Sprite2D").texture.get_height()
			var obs_scale : Vector2 = obstacle_instance.get_node("Sprite2D").scale
			var obs_x : int = screen_size.x + score - 1000 + (i * 500)
			var obs_y : int = screen_size.y - floor_height - (obs_height * obs_scale.y /2) + 480
			#480
			prev_obs = obstacle_instance
			add_obstacle(obstacle_instance, obs_x, obs_y)
			
		if(randi() % 2) == 0:
			obstacle_instance = arrow_scene.instantiate()
			var obs_x : int = screen_size.x + score - 1000
			var obs_y : int = arrow_heights[randi() % arrow_heights.size()]
			add_obstacle(obstacle_instance, obs_x, obs_y)


func add_obstacle(obstacle, x , y) -> void:
	obstacle.position = Vector2i(x, y)
	add_child(obstacle)
	current_obstacles.append(obstacle)



func delete_obstacle(obstacle):
	obstacle.queue_free()
	current_obstacles.erase(obstacle)
