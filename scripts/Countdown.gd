extends Control

@export var countdown_time = 60 # Countdown time in seconds
var time_left
var stopped = false

signal out_of_time

# Called when the node enters the scene tree for the first time.
func _ready():
	print("Countdown Scene Ready")
	time_left = countdown_time
	$CountdownTimer.start()
	update_timer_label()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !stopped:
		if time_left > 0:
			time_left -= delta
			update_timer_label()
		else:
			time_left = 0
			stopped = true
			emit_signal("out_of_time")
			update_timer_label()


func update_timer_label():
	var seconds = int(time_left) % 60
	var label = get_node("BackgroundPanel/Time")
	label.text = str(seconds)


func _on_countdown_timer_timeout():
	print("Placeholder")
