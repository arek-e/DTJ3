extends Control

var is_open = false
signal opened
signal closed

@onready var inventory: Inventory = preload("res://gui/inventory/items/player_inventory.tres")
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()

func _ready():
	update()

func update():
	for i in range(min(inventory.items.size(), slots.size())):
		print(inventory.items[i])
		slots[i].update(inventory.items[i])

func open() -> void:
	visible = true
	is_open = true
	opened.emit()
	
func close() -> void:
	visible = false
	is_open = false
	closed.emit()
	
