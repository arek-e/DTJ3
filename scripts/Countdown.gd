extends Control

@onready var player_asset = preload("res://prefab/player.tscn")
@onready var player = null

@export var countdown_time = 60 # Countdown time in seconds
var time_left

# Called when the node enters the scene tree for the first time.
func _ready():
	print("Countdown Scene Ready")
	time_left = countdown_time
	$CountdownTimer.start()
	update_timer_label()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if time_left > 0:
		time_left -= delta
		update_timer_label()
	else:
		time_left = 0
		update_timer_label()


func update_timer_label():
	var seconds = int(time_left) % 60
	var label = get_node("BackgroundPanel/Time")
	label.text = str(seconds)


func _on_countdown_timer_timeout():
	print("Placeholder")
