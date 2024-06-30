extends Node2D

@onready var required_recipe: CraftingRecipe
@onready var tooltip: Label = $Label
@onready var animation_player = $AnimationPlayer
@onready var recipe_container = $GridContainer

@onready var mix_slot_scene = preload("res://potion mixer/mixer_slot_item.tscn")

var player_inventory: Inventory
var is_player_in_area = false
var collected_items: Array[InventoryItem]

# Called when the node enters the scene tree for the first time.
func _ready():
	tooltip.hide()
	

func _process(delta):
	if is_player_in_area:
		tooltip.show()
		if Input.is_action_just_pressed("DropItem"):
			drop_item()
	else:
		tooltip.hide()


# Function to handle item dropping logic
func drop_item():
	if player_inventory:
		var dropped_item = player_inventory.drop_current_item()
		if dropped_item:
			collected_items.insert(0, dropped_item)
			animation_player.play("Mix")
			add_item_to_container(dropped_item)
		else:
			print("No item was dropped")


func add_item_to_container(item: InventoryItem):
	var mix_slot = mix_slot_scene.instantiate() as Control
	mix_slot.setup(item)
	recipe_container.add_child(mix_slot)


func _on_area_entered(area: Area2D):
	print_debug(area.name)
	if area.name == "player_hurtBox":
		is_player_in_area = true
		player_inventory = area.get_parent().inventory

func _on_area_exited(area):
	if area.name == "player_hurtBox":
		is_player_in_area = false
		player_inventory = null
