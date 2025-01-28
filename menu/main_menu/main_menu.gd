class_name MainMenu
extends Node2D
## Main Menu of the game.
##
## Contains 3 buttons - Play, Settings & Exit.
## Is replaced by other nodes depending on the button pressed.

# When the node loads for the first time, the AnimationPlayer includes the theme song of the main menu.
# To make sure it does continue after the animation ended, we must play it manually, but from this exact point.
# The value is based on the timeline of the AnimationPlayer's Fade In animation.
const _MUSIC_STARTING_POINT_FOR_INITIAL_LOAD: float = 2.5


# Opens the Level Selection Menu.
@onready var _play: Button = $ClickableElements/Play
# Opens the Settings Menu.
@onready var _settings: Button = $ClickableElements/Settings
# Closes the game.
@onready var _exit: Button = $ClickableElements/Exit
# Handles the animations and the sound effects for the loading screen.
@onready var _loading_animation_player: AnimationPlayer = $CosmeticElements/LoadingAnimation
# Plays the theme song of the main menu.
@onready var _music_player: AudioStreamPlayer = $MusicPlayer


func _ready() -> void:
	_loading_animation_player.play(&"fade_in")
	await _loading_animation_player.animation_finished
	_music_player.stream = preload("res://resources/audio/music/main_menu.wav")
	if Global.first_load:
		_music_player.play(_MUSIC_STARTING_POINT_FOR_INITIAL_LOAD)
		Global.first_load = false
	else:
		_music_player.play()
	
	var _discard: int
	if not _play.is_connected("pressed", _on_play_pressed):
		_discard = _play.pressed.connect(_on_play_pressed)
	if not _settings.is_connected("pressed", _on_settings_pressed):
		_discard = _settings.pressed.connect(_on_settings_pressed)
	if not _exit.is_connected("pressed", _on_exit_pressed):
		_discard = _exit.pressed.connect(_on_exit_pressed)


func _on_play_pressed() -> void:
	pass


func _on_settings_pressed() -> void:
	pass


func _on_exit_pressed() -> void:
	Global.save_settings()
	get_tree().quit()
