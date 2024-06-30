extends Node

class_name ItemSpawnManager

var item_node_test = preload("res://collectable/collectables/Coin.tscn")
var item_dead_fish = preload("res://collectable/collectables/DeadFish.tscn")
var item_half_empty_flask = preload("res://collectable/collectables/HalfEmptyFlask.tscn")

var item_id_list : Dictionary = {
	"Dead_fish" : item_dead_fish,
	"Flask_empty_item" : item_node_test,
	"Flask_half_full_blue_item" : item_half_empty_flask
}

var item_list: Array = []

func get_item_with_index(item_index: int):
	if item_index > len(item_id_list) - 1 || item_index < 0:
		print("Warning: Trying to get an item outside of item list range.")
		return
	return item_id_list.keys()[item_index] # Makes it only return the key.. not great?

func _ready():
	item_list.append(item_node_test)
	item_list.append(item_dead_fish)
	item_list.append(item_half_empty_flask)
	
func get_all_items() -> Array:
	return item_list
	
func spawn_world_items():
	spawn_item(item_dead_fish, Vector2(100, 200))
	spawn_item(item_node_test, Vector2(250, 100))
	spawn_item(item_half_empty_flask, Vector2(200, 150))
	# spawn_item(item_node_test, Vector2(250, 250))

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
