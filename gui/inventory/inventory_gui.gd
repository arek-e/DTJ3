extends Control

var is_open = false
signal opened
signal closed

@onready var inventory: Inventory = preload("res://gui/inventory/items/player_inventory.tres")
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()

var active_slot_index = 0

func _ready():
	inventory.updated.connect(update)
	update()
	changeSlot(0)

func update():
	for i in range(min(inventory.items.size(), slots.size())):
		slots[i].update(inventory.items[i])

func open() -> void:
	visible = true
	is_open = true
	opened.emit()
	
func close() -> void:
	visible = true
	is_open = true
	closed.emit()

func changeSlot(slot_index: int) -> void:
	active_slot_index = slot_index
	
	# Ugly way, I hate it :D
	if slot_index == 0:
		inventory.current_item_index = slot_index
		$NinePatchRect/GridContainer/InventorySlot0.grab_focus()
	elif slot_index == 1:
		inventory.current_item_index = slot_index
		$NinePatchRect/GridContainer/InventorySlot1.grab_focus()
	elif slot_index == 2:
		inventory.current_item_index = slot_index
		$NinePatchRect/GridContainer/InventorySlot2.grab_focus()
	elif slot_index == 3:
		inventory.current_item_index = slot_index
		$NinePatchRect/GridContainer/InventorySlot3.grab_focus()
	elif slot_index == 4:
		inventory.current_item_index = slot_index
		$NinePatchRect/GridContainer/InventorySlot4.grab_focus()


func _on_inventory_slot_0_pressed():
	changeSlot(0)

func _on_inventory_slot_1_pressed():
	changeSlot(1)

func _on_inventory_slot_2_pressed():
	changeSlot(2)

func _on_inventory_slot_3_pressed():
	changeSlot(3)

func _on_inventory_slot_4_pressed():
	changeSlot(4)

