extends Resource

class_name Inventory

signal updated

@export var items: Array[InventoryItem]
var available_inventory_slots = 5	# Must update after chaning items.size!!

func insert(item: InventoryItem):
	for i in range(items.size()):
		if !items[i]:
			if available_inventory_slots != 0:
				available_inventory_slots -= 1
			items[i] = item
			break
	
	updated.emit()

func get_amount_of_empty_slots() -> int:
	return available_inventory_slots
