extends Node

class_name ItemSpawnManager

var item_dead_fish = preload("res://collectable/collectables/DeadFish.tscn")
var item_half_empty_flask = preload("res://collectable/collectables/HalfEmptyFlask.tscn")
var item_death_fungus = preload("res://collectable/collectables/DeathFungus.tscn")
var item_desert_fungus = preload("res://collectable/collectables/DesertFungus.tscn")
var item_posion_fungus = preload("res://collectable/collectables/PoisionFungus.tscn")


var item_id_list : Dictionary = {
	"DeadFish" : item_dead_fish,
	"HalfEmptyBlueFlask" : item_half_empty_flask,
	"DeathFungus" : item_death_fungus,
	"DesertFungus" : item_desert_fungus,
	"PoisionFungus" : item_posion_fungus
}

var item_list: Array = []

func get_item_with_index(item_index: int):
	if item_index > len(item_id_list) - 1 || item_index < 0:
		print("Warning: Trying to get an item outside of item list range.")
		return
	return item_id_list.keys()[item_index] # Makes it only return the key.. not great?

func _ready():
	item_list.append(item_dead_fish)
	item_list.append(item_half_empty_flask)
	item_list.append(item_death_fungus)
	item_list.append(item_desert_fungus)
	item_list.append(item_posion_fungus)
	
func get_all_items() -> Array:
	return item_list
	
func spawn_world_items():
	spawn_item(item_dead_fish, Vector2(100, 200))
	spawn_item(item_half_empty_flask, Vector2(200, 150))
	spawn_item(item_death_fungus, Vector2(250, 250))
	spawn_item(item_posion_fungus, Vector2(300, 250))
	spawn_item(item_desert_fungus, Vector2(250, 300))

func spawn_item(object, position: Vector2) -> void:
	# Instance the item scene
	var item_instance = object.instantiate()
	
	# Set the position of the item instance
	item_instance.position = position
	
	# Add the item instance to the current scene
	add_child(item_instance)

func spawn_item_from_item_list(item_index: int, position: Vector2):
	if !item_list || len(item_list) == 0:
		print("Warning: No items exists in known items for spawn_manager.")
		return
	
	if item_index > len(item_list) - 1:
		print("Warning: A item attempted to spawn that was out of item_list range indexes.")
		return
		
	spawn_item(item_list[item_index], position)
