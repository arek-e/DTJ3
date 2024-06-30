extends Node2D

@onready var tile_map = $"../TileMap"
@onready var character_sprite = $Character/CharacterSprite
@onready var move_timer = $Character/TileMovementDelayTimer
@onready var animation_player = $AnimationPlayer
@onready var hurtBox = $player_hurtBox
@export var inventory: Inventory
@onready var raycast = $RayCast2D

var can_move = true
var is_dead = false
var is_moving = false
var move_delay = 0.2
var movement_speed = 3

var current_tile_pos: Vector2
var target_tile_pos: Vector2

signal pickupSound

func _ready():
	move_timer.connect("timeout", Callable(self, "_on_move_timer_timeout"))
	set_move_delay(move_delay)

func _physics_process(delta):
	if is_moving == false && is_dead == false:
		animation_player.queue("Idle")
		return
		
	if global_position == character_sprite.global_position && is_dead == false:
		animation_player.queue("Idle")
		is_moving = false
		return
	
	character_sprite.global_position = character_sprite.global_position.move_toward(global_position, movement_speed)

func _process(delta):
	if can_move:
		if Input.is_action_pressed("up"):
			animation_player.play("Running-backwards")
			move(Vector2.UP)
			start_move_delay()
		elif Input.is_action_pressed("down"):
			animation_player.play("Running-forward")
			move(Vector2.DOWN)
			start_move_delay()
		elif Input.is_action_pressed("left"):
			animation_player.play("Running-Left")
			move(Vector2.LEFT)
			start_move_delay()
		elif Input.is_action_pressed("right"):
			animation_player.play("Running-Right")
			move(Vector2.RIGHT)
			start_move_delay()
		
		if Input.is_action_pressed("DropItem"):
			var areas: Array[Area2D] = hurtBox.get_overlapping_areas()
	
			for area in areas:
				# If the player is standing in the mixer area then dont drop item
				if(area.name == "Mixer"):
					return
			
			# inventory.drop_current_item()
			
func move(direction: Vector2):
	if (tile_map == null):
		print("Error: tile_map is null!")
		return
		
	var current_tile: Vector2i = tile_map.local_to_map(global_position)
	current_tile_pos = tile_map.map_to_local(current_tile)  # Store the position for visualization

	var target_tile: Vector2i = Vector2i(
		current_tile.x + direction.x,
		current_tile.y + direction.y
	)
	target_tile_pos = tile_map.map_to_local(target_tile)  # Store the position for visualization


	var direction_vector: Vector2 = target_tile_pos - current_tile_pos
	var shortened_vector: Vector2 = direction_vector * 0.9
	var shortened_target_pos: Vector2 = current_tile_pos + shortened_vector

	# Calculate the position slightly behind the current position
	var backward_adjustment: Vector2 = direction_vector * (-0.2)  # Adjust this value to control how much to move back
	var adjusted_current_pos: Vector2 = current_tile_pos + backward_adjustment

	# Raycast to check for obstacles
	raycast.enabled = true
	raycast.global_position = adjusted_current_pos
	raycast.target_position = to_local(shortened_target_pos)
	
	# Get the current transform
	if direction.y > 0 && direction.y < 0:
		var transform = raycast.transform
		var move_amount = 8.0  # Adjust this value as needed

		if direction.y > 0:
			transform.origin.y -= move_amount
		elif direction.y < 0:
			transform.origin.y += move_amount

		print_debug(transform.origin)
		print_debug(direction)
		raycast.transform = transform
	
	raycast.force_raycast_update()  # Force an immediate update to check for collisions

	if raycast.is_colliding():
		print("Obstacle detected! Move blocked.")
		raycast.enabled = false
		return
	
	
	is_moving = true
		
	# Move Player
	global_position = tile_map.map_to_local(target_tile)
	
	character_sprite.global_position = tile_map.map_to_local(current_tile)
	queue_redraw()
	raycast.enabled = false
	

func on_death():
	is_dead = true
	animation_player.play("Death")
	can_move = false  # Prevent player from moving during death animation


func start_move_delay():
	can_move = false
	move_timer.start()

func _on_move_timer_timeout():
	can_move = true
	
func set_move_delay(new_delay):
	move_timer.wait_time = new_delay

func _on_hurt_box_area_entered(area):
	if area.has_method("collect"):
		if inventory.get_amount_of_empty_slots() > 0:
			emit_signal("pickupSound")
			area.collect(inventory)
		


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "Death":
		character_sprite.texture = load("res://assets/custom/Nervous-Scientist.png")
		character_sprite.hframes = 1
		character_sprite.vframes = 1

func _draw():
	print("Drawing debug circles")
	if current_tile_pos:
		draw_circle(to_local(current_tile_pos), 10, Color(0, 1, 0))  # Draw green circle for current tile
	
	if target_tile_pos:
		draw_circle(to_local(target_tile_pos), 10, Color(1, 0, 0))  # Draw red circle for target tile
