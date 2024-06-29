extends CharacterBody2D

var currentPosition = [0, 0]

func _input(event):
	if event.is_action_pressed("ui_right"):
		currentPosition[0] += 32
		get_node("CharacterSprite").look_at(self.position + Vector2(1, 0))
	elif event.is_action_pressed("ui_left"):
		currentPosition[0] -= 32
		get_node("CharacterSprite").look_at(self.position + Vector2(-1, 0))
	elif event.is_action_pressed("ui_up"):
		currentPosition[1] -= 32
		get_node("CharacterSprite").look_at(self.position + Vector2(0, -1))
	elif event.is_action_pressed("ui_down"):
		currentPosition[1] += 32
		get_node("CharacterSprite").look_at(self.position + Vector2(0, 1))
		
	self.position = Vector2(currentPosition[0], currentPosition[1])
