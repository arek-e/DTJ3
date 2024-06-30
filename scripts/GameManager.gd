extends Node2D

var item_spawn_manager_asset = preload("res://item_spawn_manager.tscn")
var spawn_manager = null # Node2D object for spawn manager that has the script on it.

var sound_manager_asset = preload("res://SoundManager.tscn")
var sound_manager = null

var player_asset = preload("res://prefab/player.tscn")
var player = null
var player_spawn_position = Vector2(100, 100)

var countdown_asset = preload("res://scenes/countdown_scene.tscn")
var countdown_clock = null

func _ready():
	create_sound_manager()
	create_spawn_manager()
	
	if !sound_manager:
		print("ERROR: SoundManager node not found!")
	
	if spawn_manager != null:
		spawn_manager.spawn_world_items()
	else:
		print("ERROR: SpawnManager node not found!")
		
	spawn_player()
	player.inventory.connect("dropItem", player_drop_item)
	player.connect("pickupSound", play_player_pickup_sound) # TODO: Stupid, how to make a general thing?
	
	spawn_countdown_clock()
	countdown_clock.connect("out_of_time", end_game_victory)

func create_spawn_manager() -> void:
	spawn_manager = item_spawn_manager_asset.instantiate()
	add_child(spawn_manager)
	
func create_sound_manager() -> void:
	sound_manager = sound_manager_asset.instantiate()
	add_child(sound_manager)

func spawn_player() -> void:
	player = player_asset.instantiate()
	player.position = player_spawn_position
	add_child(player)

func spawn_countdown_clock() -> void:
	var gui = get_node("CanvasLayer")
	countdown_clock = countdown_asset.instantiate()
	gui.add_child(countdown_clock)
	
func player_drop_item() -> void:
	print("Player attempted to drop item")
	spawn_manager.spawn_item_from_item_list(0, player.position) # TODO: Must pass a actual item.
	player.inventory.current_item_index

func end_game_victory():
	print("Victory!")
	sound_manager.play_victory()

# Stupid code below:

func play_player_pickup_sound():
	sound_manager.play_player_pickup_sound()
