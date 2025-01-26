class_name Enemy
extends CharacterBody2D


const MAX_HP: int = 100
const TERMINAL_VELOCITY: float = 1000.0

@export var health: int

@onready var animated_sprite_2d: AnimatedSprite2D


func _ready() -> void:
	if has_method("play_animation"):
		call("play_animation", "run")


func _physics_process(_delta: float) -> void:
	var _discard: int = move_and_slide()
	
	for i: int in get_slide_collision_count():
		var collision: KinematicCollision2D = get_slide_collision(i)
		if collision:
			var impact_velocity: float = velocity.length()
			handle_collision(impact_velocity)


func handle_collision(impact_velocity: float) -> void:
	var damage_ratio: float = clampf(impact_velocity / TERMINAL_VELOCITY, 0.0, 1.0)
	var damage: int = ceil(MAX_HP * damage_ratio)
	take_damage(damage)
 

func take_damage(damage: int) -> void:
	health -= damage
	if health < 0:
		die()
	elif animated_sprite_2d != null:
		animated_sprite_2d.play(&"hurt")
		await animated_sprite_2d.animation_finished
		animated_sprite_2d.play(&"idle")


func die() -> void:
	if animated_sprite_2d != null:
		animated_sprite_2d.play(&"death")
		await animated_sprite_2d.animation_finished
	queue_free()
