extends CanvasLayer

@onready var inventory: Control = $InventoryGui

func _input(event: InputEvent) -> void:
	if(event.is_action_pressed("toggle_inventory")):
		if inventory.is_open:
			inventory.close()
		else:
			inventory.open()
	
	


# Called when the node enters the scene tree for the first time.
func _ready():
	inventory.close()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
