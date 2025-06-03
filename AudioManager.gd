extends Node
## Autoload singleton for handling the sfx for the buttons.
# Add an AudioStream player, then start the stream. Then start the playback and store it in a variable.
# If a node enters the tree and is a button, connect to the hover and pressed signals.
# When the signals are emitted, play the hover/clicked sound through the audio stream playback.


const _HOVER_SOUND: AudioStream = preload("res://resources/audio/sfx/button_hover.wav")
const _PRESSED_SOUND: AudioStream = preload("res://resources/audio/sfx/button_clicked.wav")
# To make the UI more organic, we will set the pitch_scale to a random value between the below defined lower- and
# upper-limit. The difference between them should be small to keep it subtle but noticeable, as too big of a difference
# would make the interface inconsistent.
const _PITCH_LOWER_LIMIT: float = 0.9
const _PITCH_UPPER_LIMIT: float = 1.1


var _playback:AudioStreamPlaybackPolyphonic


func _enter_tree() -> void:
	var player: AudioStreamPlayer = AudioStreamPlayer.new()
	add_child(player)
	
	var stream: AudioStreamPolyphonic = AudioStreamPolyphonic.new()
	stream.polyphony = 32
	player.stream = stream
	player.play()
	_playback = player.get_stream_playback()
	
	var _discard:int = get_tree().node_added.connect(_on_node_added)


func _on_node_added(node:Node) -> void:
	if node is Button:
		var button: Button = node
		var _discard: int
		_discard = button.mouse_entered.connect(_play_hover)
		_discard = button.pressed.connect(_play_pressed)


func _play_hover() -> void:
	var _discard: int = _playback.play_stream(_HOVER_SOUND, 0, 0, randf_range(_PITCH_LOWER_LIMIT, _PITCH_UPPER_LIMIT))


func _play_pressed() -> void:
	var _discard: int = _playback.play_stream(_PRESSED_SOUND, 0, 0, randf_range(_PITCH_LOWER_LIMIT, _PITCH_UPPER_LIMIT))
