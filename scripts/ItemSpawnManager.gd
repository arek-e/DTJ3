extends Node

class_name ItemSpawnManager

var item_node_test = preload("res://collectable/collectables/Coin.tscn")
	
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
