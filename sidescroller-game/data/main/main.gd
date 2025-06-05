class_name Main
extends Node2D


@export var camera : Camera2D
@export var player : Player
@export var floor : StaticBody2D
@export var hud : Control

var arrow_scene : PackedScene = preload("res://scenes/obstacles/Arrow.tscn")
var rock_scene : PackedScene = preload("res://scenes/obstacles/Rock.tscn")


var game_ongoing : bool = false
var max_obs : int = 3
var obstacle_types : Array = [rock_scene]
var current_obstacles : Array = []
var arrow_heights : Array = [325, 310, 295]
var cam_speed : float = .8
var screen_size : Vector2i
var prev_obs
var floor_height : float
var lives_label : Label
var current_lives : int = 3

func _ready() -> void:
	lives_label = hud.get_node("Lives")
	lives_label.text = "Lives: " + str(current_lives)
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
		var obstacle_instance : Node
		
		for i in range(randi() % max_obs + 1):
			obstacle_instance = obs_type.instantiate()
			prev_obs = obstacle_instance
			var obs_height : float = obstacle_instance.get_node("Sprite2D").texture.get_height()
			var obs_scale : Vector2 = obstacle_instance.get_node("Sprite2D").scale
			var obs_x : int = screen_size.x + camera.position.x - 1000
			var obs_y : int = screen_size.y - floor_height - (obs_height * obs_scale.y /2) + 480
			add_obstacle(obstacle_instance, obs_x, obs_y)
			
		if(randi() % 2) == 0:
			obstacle_instance = arrow_scene.instantiate()
			var obs_x : int = screen_size.x + camera.position.x - 1000
			var obs_y : int = arrow_heights[randi() % arrow_heights.size()]
			add_obstacle(obstacle_instance, obs_x, obs_y)


func add_obstacle(obstacle, x , y) -> void:
	obstacle.position = Vector2i(x, y)
	obstacle.body_entered.connect(on_hit)
	add_child(obstacle)
	current_obstacles.append(obstacle)


func delete_obstacle(obstacle):
	obstacle.queue_free()
	current_obstacles.erase(obstacle)

# TODO fix this thingy and collision detection showing player get hit
func on_hit(body : CharacterBody2D) -> void:
	if body.is_in_group("player"):
		current_lives = current_lives - 1
		lives_label.text = "Lives: " + str(current_lives)
