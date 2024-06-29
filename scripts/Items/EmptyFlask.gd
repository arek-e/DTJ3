# EmptyFlask.gd
extends "res://Item.gd"  # Ensure the path is correct to the Item.gd script

# Define the class name
class_name EmptyFlask

# Override properties if needed or add new ones
@export var name : String = "Empty Flask"
@export var can_be_eaten : bool = false
@export var is_craftable : bool = true
