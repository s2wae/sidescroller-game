class_name Main
extends Node2D

@export var camera : Camera2D
@export var player : Player
@export var floor : StaticBody2D
@export var hud : Control

var arrow_scene : PackedScene = preload("res://scenes/Arrow.tscn")
var rock_scene : PackedScene = preload("res://scenes/Rock.tscn")


var game_ongoing : bool = false
var max_obs : int = 3
var obstacle_types : Array = [rock_scene]
var current_obstacles : Array = []
var arrow_heights : Array = [325, 310, 295]
var cam_speed : float = .8
var screen_size : Vector2i
var prev_obs
var floor_height : float

func _ready() -> void:
	screen_size = get_window().size
	floor_height = floor.get_node("Front").texture.get_height()


func _process(delta: float) -> void:
	
	generate_obstacle()
	
	camera.position.x += cam_speed
	player.position.x += cam_speed
	
	if camera.position.x - floor.position.x > 928 * 1.5:
		floor.position.x += 928
		
	for obstacles in current_obstacles:
		if obstacles.position.x < (camera.position.x - screen_size.x * 0.2):
			delete_obstacle(obstacles)


func generate_obstacle() -> void:
	if current_obstacles.is_empty():
		var obs_type : PackedScene = obstacle_types[randi() % obstacle_types.size()]
		
		for i in range(randi() % max_obs + 1):
			var obstacle_instance = obs_type.instantiate()
			prev_obs = obstacle_instance
			var obs_height : float = obstacle_instance.get_node("Sprite2D").texture.get_height()
			var obs_scale : Vector2 = obstacle_instance.get_node("Sprite2D").scale
			var obs_x : int = screen_size.x + camera.position.x - 1000
			var obs_y : int = screen_size.y - floor_height - (obs_height * obs_scale.y /2) + 480
			add_obstacle(obstacle_instance, obs_x, obs_y)
			print(obs_x) 
			print(obs_y)


func add_obstacle(obstacle, x , y) -> void:
	obstacle.position = Vector2i(x, y)
	add_child(obstacle)
	current_obstacles.append(obstacle)
		

func delete_obstacle(obstacle):
	obstacle.queue_free()
	current_obstacles.erase(obstacle)
