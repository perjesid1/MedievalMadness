class_name Settings
extends Node2D
## Settings Menu of the game.
##
## Contains the following controls:
##		- Music volume slider
##		- SFX volume slider
##		- Resume Button (if was opened from a game session)
##		- Main Menu Button
## Is replaced by other nodes depending on the button pressed.
@onready var volume_slider: CustomSlider = $ClickableElements/VolumeSlider

func _ready() -> void:
	volume_slider.setting_name = "Volume"
	volume_slider.label_text = "Volume"
	volume_slider.min_value = 0.0
	volume_slider.max_value = 100.0
	volume_slider.step = 1.0
	volume_slider.current_value = 50.0
	
