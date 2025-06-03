class_name DefaultGoblin
extends Enemy

#var _animation_offsets: Dictionary = {
	#"idle": Vector2(0, -16),
	#"death": Vector2(0, -32),
	#"hurt": Vector2(0, -32),
	#"run": Vector2(0, -32)
#}

func play_animation(anim_name: String) -> void:
	var animation_player: AnimationPlayer = $AnimationPlayer
	#animation_player.offset = _animation_offsets[anim_name]
	animation_player.play(anim_name)
	await animation_player.animation_finished
