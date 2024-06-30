class_name HitBox
extends Area2D


@export var damage := 1


func _init():
	collision_layer = 3
	collision_mask = 2