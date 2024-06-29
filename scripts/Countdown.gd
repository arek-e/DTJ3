extends Control

@onready var label = $Time
@onready var timer = $CountdownTimer

# Called when the node enters the scene tree for the first time.
func _ready():
	timer.start()

func time_left():
	var time_left_var = timer.time_left
	var second = int(time_left_var) % 60
	return [second]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	label.text = "%02d" % time_left()
