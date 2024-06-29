extends Control

var is_open = false

func open() -> void:
	visible = true
	is_open = true
	
func close() -> void:
	visible = false
	is_open = false
	