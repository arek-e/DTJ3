class_name HurtBox
extends Area2D


func _init():
	collision_layer = 3
	collision_mask = 2


func _ready():
	self.connect("area_entered", Callable(self, "_on_area_entered"))


func _on_area_entered(hitbox: HitBox): 
	if hitbox == null:
		return

	if owner.has_method("take_damage"):
		owner.take_damage(hitbox.damage)