class_name PlayerCam
extends Camera2D

@export var random_strength: float = 10.0
@export var shake_fade: float = 3.0
@export var _shake_time: float = 0.2

var rng = RandomNumberGenerator.new()
var shake_strenght: float = 0.0
var current_shake_time: float = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	current_shake_time = _shake_time

func apply_shake(shake_time, delta) -> int:
	print("1. Shake time is: ", shake_time)
	if shake_time > 0.0:
		shake_time -= delta
		print("2. Shake time is: ", shake_time)
		if shake_time >= 0.0:
			shake_strenght = random_strength
			if shake_strenght > 0.0:
				shake_strenght = lerpf(shake_strenght, 0, shake_fade * delta)
				offset = randomOffset()
	else:
		offset = Vector2.ZERO
	return shake_time

func randomOffset() -> Vector2:
	return Vector2(rng.randf_range(-shake_strenght, shake_strenght), rng.randf_range(-shake_strenght, shake_strenght))
