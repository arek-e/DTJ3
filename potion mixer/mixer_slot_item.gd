extends Control

@onready var sprite: Sprite2D = $CenterContainer/Panel/Sprite2D
@onready var parent_container: Panel = $CenterContainer/Panel

func _ready():
	pass


func setup(item: InventoryItem):
	if sprite == null:
		_ready()  # Manually call _ready if sprite is not initialized

	sprite.texture = item.texture
	#scale_sprite_to_fit_container()

func scale_sprite_to_fit_container():
	var parent_size = parent_container.get_rect().size
	var texture_size = sprite.texture.get_size()
	var scale_factor = min(parent_size.x / texture_size.x, parent_size.y / texture_size.y)
	sprite.scale = Vector2(scale_factor, scale_factor)
