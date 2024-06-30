extends Node

func _ready():
	play_background_noise()
	
func play_player_pickup_sound():
	$"AP-Player-PickUpObject".play()

func play_item_break():
	$"AP-Item-Broken".play()

func play_victory():
	$"AP-Victory".play()

func play_background_noise():
	$"AP-Machine-background-noise".play()
	
func play_death_scream():
	$"AP-Deathscream".play()
