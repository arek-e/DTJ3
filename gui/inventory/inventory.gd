extends Resource

class_name Inventory

signal updated
signal dropItem

@export var items: Array[InventoryItem]
var available_inventory_slots = 5	# Must update after chaning items.size!!
@export var current_item_index = 0

func insert(item: InventoryItem):
	for i in range(items.size()):
		if !items[i]:
			if available_inventory_slots != 0:
				available_inventory_slots -= 1
				
			print(item.name)
			items[i] = item
			break
	
	updated.emit()

func get_amount_of_empty_slots() -> int:
	return available_inventory_slots

func drop_current_item() -> InventoryItem:
	if items[current_item_index] != null:
		available_inventory_slots += 1
		var item: InventoryItem = items[current_item_index]
		emit_signal("dropItem")
		clear_item_from_array(current_item_index)
		return item
	else:
		return null

func clear_item_from_array(item_index: int):
	items[item_index] = null
	updated.emit()
