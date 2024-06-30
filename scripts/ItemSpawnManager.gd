extends Node

class_name ItemSpawnManager

var item_dead_fish = preload("res://collectable/collectables/DeadFish.tscn")
var item_half_empty_flask = preload("res://collectable/collectables/HalfEmptyFlask.tscn")
var item_death_fungus = preload("res://collectable/collectables/DeathFungus.tscn")
var item_desert_fungus = preload("res://collectable/collectables/DesertFungus.tscn")
var item_posion_fungus = preload("res://collectable/collectables/PoisionFungus.tscn")

var collectible_spawn_points: Array = [
	Vector2(494, 291),
	Vector2(302, 195),
	Vector2(654, 259),
	Vector2(622, 131),
	Vector2(462, 131),
	Vector2(430, 227),
	Vector2(462, 387),
	Vector2(686, 387),
]

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

func pick_random_points(points_array: Array, number_of_points: int) -> Array:
	var selected_points = []
	for i in range(number_of_points):
		if points_array.size() == 0:
			break
		var index = randi() % points_array.size()
		selected_points.append(points_array[index])
		points_array.pop_at(index)
	return selected_points
	
func spawn_world_items():
	var selected_points = pick_random_points(collectible_spawn_points, 5)
	spawn_item(item_dead_fish, selected_points[0])
	spawn_item(item_half_empty_flask, selected_points[1])
	spawn_item(item_death_fungus, selected_points[2])
	spawn_item(item_posion_fungus, selected_points[3])
	spawn_item(item_desert_fungus, selected_points[4])
	
	

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
