extends Control

var item_slot_paths = [
	NodePath("Panel/ItemSlot01"),
	NodePath("Panel/ItemSlot02"),
	NodePath("Panel/ItemSlot03")
]

func change_slot(slot_index: int, item_name: String):
	# Ensure the slot index is within the valid range
	if slot_index >= 0 and slot_index < item_slot_paths.size():
		var slot_path = item_slot_paths[slot_index]
		var slot = get_node(slot_path)
		
		# Check if the slot is not null before setting the icon
		if slot:
			var icon_path = "res://assets/Items/" + item_name + ".png"
			slot.icon = load(icon_path)
		else:
			print("Error: Slot at index " + str(slot_index) + " is null.")
	else:
		print("Error: Slot index " + str(slot_index) + " is out of range.")
