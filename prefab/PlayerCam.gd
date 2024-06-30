extends Camera2D

@export var random_strength: float = 10.0
@export var shake_fade: float = 3.0
@export var shake_time: float = 1.0

var rng = RandomNumberGenerator.new()
var shake_strenght: float = 0.0
var current_shake_time: float = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	current_shake_time = shake_time

func apply_shake():
	shake_strenght = random_strength

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if current_shake_time > 0:
		current_shake_time -= delta
		if current_shake_time <= 0:
			shake_strenght = 0
			offset = Vector2.ZERO
		else:
			apply_shake()
			if shake_strenght > 0:
				shake_strenght = lerpf(shake_strenght, 0, shake_fade * delta)
				offset = randomOffset()
	else: 
		offset = Vector2.ZERO

func randomOffset() -> Vector2:
	return Vector2(rng.randf_range(-shake_strenght, shake_strenght), rng.randf_range(-shake_strenght, shake_strenght))
