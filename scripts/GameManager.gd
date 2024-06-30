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

var recipe_gui_asset = preload("res://gui/recipe/recipe_gui.tscn")
var recipe_gui = null

var mixer_asset = preload("res://potion mixer/mixer.tscn")
var mixer = null

var recipe = null

func _ready():
	create_sound_manager()
	create_spawn_manager()
	spawn_mixer()
	
	if !sound_manager:
		print("ERROR: SoundManager node not found!")
	
	if spawn_manager != null:
		spawn_manager.spawn_world_items()
	else:
		print("ERROR: SpawnManager node not found!")
		
	spawn_player()
	player.inventory.connect("dropItem", player_drop_item)
	player.connect("pickupSound", play_player_pickup_sound) # TODO: Stupid, how to make a general thing?
	
	mixer.connect("mixing_complete", end_game)
	
	spawn_countdown_clock()
	countdown_clock.connect("out_of_time", end_game_time_out)
	
	spawn_recipe_gui()
	apply_recipe_to_gui()

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
	
func spawn_mixer():
	mixer = mixer_asset.instantiate()
	mixer.position = $SpawnPoints/MixerSpawnPoint.position
	add_child(mixer)
	
func spawn_recipe_gui() -> void:
	var gui = get_node("CanvasLayer")
	recipe_gui = recipe_gui_asset.instantiate()
	gui.add_child(recipe_gui)
	
func player_drop_item() -> void:
	spawn_manager.spawn_item_from_item_list(player.inventory.current_item_index, player.position) # TODO: Must pass a actual item.

func end_game():
	var added_mixer_items_names: Array = []
	added_mixer_items_names.append(mixer.collected_items[0].name)
	added_mixer_items_names.append(mixer.collected_items[1].name)
	added_mixer_items_names.append(mixer.collected_items[2].name)
	
	var correct_mixer_items: Array = []
	correct_mixer_items.append(spawn_manager.get_item_with_index(recipe[0]))
	correct_mixer_items.append(spawn_manager.get_item_with_index(recipe[1]))
	correct_mixer_items.append(spawn_manager.get_item_with_index(recipe[2]))
	
	# Check if all items in added_mixer_items_names are in correct_mixer_items
	var all_items_correct = true

	for item_name in added_mixer_items_names:
		var found = false
		for correct_item in correct_mixer_items:
			if item_name == correct_item:  # Ensure correct_item has a name property
				found = true
				break
		if not found:
			all_items_correct = false
			break

	if all_items_correct:
		end_game_victory()
	else:
		end_game_loss()

func end_game_victory():
	print("Victory!")
	sound_manager.play_victory()
	
func end_game_loss():
	print("Loss!")
	
func end_game_time_out():
	print("End game!")
	print("Time ran out!")
	end_game_loss()

func generate_new_recipe() -> Array:
	var items = spawn_manager.get_all_items()
	
	if !items || len(items) < 3:
		print("Warning: Not enough items for recipes!")
		return []
	
	var recpie_ids = []
	
	while recpie_ids.size() < 3:
		var rand_num = randi_range(0, len(spawn_manager.get_all_items()) - 1)
		if rand_num not in recpie_ids:
			recpie_ids.append(rand_num)
	
	return recpie_ids

# Stupid code below:
func apply_recipe_to_gui():
	recipe = generate_new_recipe()
	recipe_gui.change_slot(0, spawn_manager.get_item_with_index(recipe[0]))
	recipe_gui.change_slot(1, spawn_manager.get_item_with_index(recipe[1]))
	recipe_gui.change_slot(2, spawn_manager.get_item_with_index(recipe[2]))

func play_player_pickup_sound():
	sound_manager.play_player_pickup_sound()
