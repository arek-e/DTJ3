extends Control
"res://assets/coffee-mug-1.png"
func _ready():
	$MarginContainer/VBoxContainer/StartButton.grab_focus()

func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://root.tscn")

func _on_options_button_pressed():
	get_tree().change_scene_to_file("res://options_menu.tscn")

func _on_quit_button_pressed():
	get_tree().quit()
