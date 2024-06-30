extends StaticBody2D

@onready var sprite = $ObjectSprite

@export var health := 1
@export var texture: Texture2D


func _ready():
	if texture:
		sprite.texture = texture

func take_damage(amount: int):
	print("Damage: ", amount)
	health = health - amount

	if (health == 0): 
		print("Object is Dead")