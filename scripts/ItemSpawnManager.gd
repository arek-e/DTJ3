extends Node

class_name ItemSpawnManager

var item_node_test = preload("res://collectable/collectables/Coin.tscn")
	
var item_list: Array = []

func _ready():
	item_list.append(item_node_test)
	
func spawn_world_items():
	spawn_item(item_node_test, Vector2(100, 200))
	# spawn_item(item_node_test, Vector2(250, 100))
	# spawn_item(item_node_test, Vector2(200, 150))
	# spawn_item(item_node_test, Vector2(250, 250))

func spawn_item(object, position: Vector2) -> void:
	# Instance the item scene
	var item_instance = item_node_test.instantiate()
	
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
