extends Node


var playback:AudioStreamPlaybackPolyphonic


func _enter_tree() -> void:
	var player: AudioStreamPlayer = AudioStreamPlayer.new()
	add_child(player)
	
	var stream: AudioStreamPolyphonic = AudioStreamPolyphonic.new()
	stream.polyphony = 32
	player.stream = stream
	player.play()
	playback = player.get_stream_playback()
	
	var _discard:int = get_tree().node_added.connect(_on_node_added)


func _on_node_added(node:Node) -> void:
	if node is Button:
		var button: Button = node
		var _discard: int
		_discard = button.mouse_entered.connect(_play_hover)
		_discard = button.pressed.connect(_play_pressed)


func _play_hover() -> void:
	var _discard: int = playback.play_stream(preload("res://resources/audio/sfx/button_hover.wav"), 0, 0, randf_range(0.9, 1.1))


func _play_pressed() -> void:
	var _discard: int = playback.play_stream(preload("res://resources/audio/sfx/button_clicked.wav"), 0, 0, randf_range(0.9, 1.1))
