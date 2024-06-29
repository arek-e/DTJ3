extends Node

func _ready():
	$Timer.start()

func _on_timer_timeout():
	print("Timer stop")
