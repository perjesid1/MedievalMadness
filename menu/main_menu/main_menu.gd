class_name MainMenu
extends Node2D

@onready var play: Button = $ClickableElements/Play
@onready var settings: Button = $ClickableElements/Settings
@onready var exit: Button = $ClickableElements/Exit
@onready var loading_animation_player: AnimationPlayer = $CosmeticElements/LoadingAnimation


func _ready() -> void:
	loading_animation_player.play(&"fade_in")
	await(loading_animation_player.animation_finished)
	
	var _discard: int
	if not play.is_connected("pressed", _on_play_pressed):
		_discard = play.pressed.connect(_on_play_pressed)
	if not settings.is_connected("pressed", _on_settings_pressed):
		_discard = settings.pressed.connect(_on_settings_pressed)
	if not exit.is_connected("pressed", _on_exit_pressed):
		_discard = exit.pressed.connect(_on_exit_pressed)


func _on_play_pressed() -> void:
	pass


func _on_settings_pressed() -> void:
	pass


func _on_exit_pressed() -> void:
	get_tree().quit()