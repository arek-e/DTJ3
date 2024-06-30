extends Node2D

@onready var tile_map = $"../TileMap"
@onready var character_sprite = $Character/CharacterSprite
@onready var move_timer = $Character/TileMovementDelayTimer
@onready var animation_player = $AnimationPlayer

@export var inventory: Inventory

var can_move = true
var is_moving = false
var move_delay = 0.2
var movement_speed = 3



func _ready():
	move_timer.connect("timeout", Callable(self, "_on_move_timer_timeout"))
	set_move_delay(move_delay)

func _physics_process(delta):
	if is_moving == false:
		animation_player.queue("Idle")
		return
		
	if global_position == character_sprite.global_position:
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
			inventory.drop_current_item()
			
		
	

func move(direction: Vector2):
	if (tile_map == null):
		print("Error: tile_map is null!")
		return
		
	var current_tile: Vector2i = tile_map.local_to_map(global_position)
	
	var target_tile: Vector2i = Vector2i(
		current_tile.x + direction.x,
		current_tile.y + direction.y
	)
	
	var tile_data: TileData = tile_map.get_cell_tile_data(0, target_tile)
	
	# if (tile_data.get_custom_data("walkable")) == false:
	#	return
	
	is_moving = true
		
	# Move Player
	global_position = tile_map.map_to_local(target_tile)
	
	character_sprite.global_position = tile_map.map_to_local(current_tile)
	
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
			area.collect(inventory)
		
