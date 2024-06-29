extends CharacterBody2D

const SPEED = 300.0

func _physics_process(delta):
	# Get the input direction
	var direction_x = Input.get_axis("ui_left", "ui_right")
	var direction_y = Input.get_axis("ui_up", "ui_down")

	# Move left/right
	velocity.x = direction_x * SPEED

	# Move up/down
	velocity.y = direction_y * SPEED

	# Apply the movement
	move_and_slide()
