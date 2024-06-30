extends Node2D

var item_spawn_manager_asset = preload("res://item_spawn_manager.tscn")
var spawn_manager = null # Node2D object for spawn manager that has the script on it.

var player_asset = preload("res://prefab/player.tscn")
var player = null
var player_spawn_position = Vector2(100, 100)

var countdown_asset = preload("res://scenes/countdown_scene.tscn")
var countdown_clock = null

func _ready():
	create_spawn_manager()
	
	if spawn_manager != null:
		spawn_manager.spawn_world_items()
	else:
		print("ERROR: SpawnManager node not found!")
		
	spawn_player()
	spawn_countdown_clock()

func create_spawn_manager() -> void:
	spawn_manager = item_spawn_manager_asset.instantiate()
	add_child(spawn_manager)

func spawn_player() -> void:
	player = player_asset.instantiate()
	player.position = player_spawn_position
	add_child(player)

func spawn_countdown_clock():
	var gui = get_node("CanvasLayer")
	countdown_clock = countdown_asset.instantiate()
	gui.add_child(countdown_clock)
	
