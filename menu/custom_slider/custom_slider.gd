class_name CustomSlider
extends Control

@export var setting_name: String = ""
@export var min_value: float = 0.0
@export var max_value: float = 100.0
@export var current_value: float = 50.0
@export var step: float = 1.0
@export var label_text: String = ""

const BACKGROUND = preload("res://resources/gui/Bar/Background.svg")
const LINE = preload("res://resources/gui/Bar/Line.svg")

@onready var label: Label = $VBoxContainer/Label
@onready var decrease_button: Button = $HBoxContainer/DecreaseButton
@onready var progress_bar_background: TextureRect = $HBoxContainer/ProgressBar/ProgressBarBackground
@onready var progress_bar_value: TextureRect = $HBoxContainer/ProgressBar/ProgressBarValue
@onready var increase_button: Button = $HBoxContainer/IncreaseButton

signal value_changed(setting_name: String, new_value: float)

func _ready() -> void:
	progress_bar_background.texture = BACKGROUND
	progress_bar_value.texture = LINE
	
	if label_text:
		label.text = label_text
	
	if not decrease_button.has_connections("pressed"):
		decrease_button.pressed.connect(_on_decrease)
	if not increase_button.has_connections("pressed"):
		increase_button.pressed.connect(_on_increase)
	
	update_fill()

func _on_decrease() -> void:
	current_value = max(min_value, current_value - step)
	update_fill()
	value_changed.emit(setting_name, current_value)

func _on_increase() -> void:
	current_value = min(max_value, current_value + step)
	update_fill()
	value_changed.emit(setting_name, current_value)

func update_fill() -> void:
	var percentage = (current_value - min_value) / (max_value - min_value)
	progress_bar_value.size.x = progress_bar_background.size.x * percentage
