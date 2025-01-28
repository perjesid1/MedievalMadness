class_name Enemy
extends CharacterBody2D
## Base class for all enemy characters.


## Emitted upon the death of the foe.
signal died


## Maximum health of the enemies.
const MAX_HP: int = 100
## Terminal velocity of the cannon balls.
const TERMINAL_VELOCITY: float = 1000.0


## Health of the foe.
@export var health: int
## If true, the foe will be removed from the scene tree upon death.
@export var remove_upon_death: bool = false

@onready var _animated_sprite_2d: AnimatedSprite2D


func _ready() -> void:
	# Play default animation when entering the world.
	if has_method("play_animation"):
		call("play_animation", "run")


func _physics_process(_delta: float) -> void:
	var _discard: int = move_and_slide()
	
	for i: int in get_slide_collision_count():
		var collision: KinematicCollision2D = get_slide_collision(i)
		if collision:
			var impact_velocity: float = velocity.length()
			handle_collision(impact_velocity)


## Calculates the damage done based on the length of the impact velocity vector.
## This is done to ensure the power of the shot has an effect on the damage done.
func handle_collision(impact_velocity: float) -> void:
	var damage_ratio: float = clampf(impact_velocity / TERMINAL_VELOCITY, 0.0, 1.0)
	var damage: int = ceil(MAX_HP * damage_ratio)
	take_damage(damage)
 

func take_damage(damage: int) -> void:
	health -= damage
	if health <= 0:
		die()
	elif _animated_sprite_2d != null:
		_animated_sprite_2d.play(&"hurt")
		await _animated_sprite_2d.animation_finished
		_animated_sprite_2d.play(&"idle")


## Kills the enemy.
func die() -> void:
	if _animated_sprite_2d != null:
		_animated_sprite_2d.play(&"death")
		await _animated_sprite_2d.animation_finished # We should not remove the foe until the animation is finished.
	died.emit()
	if remove_upon_death:
		queue_free()


func heal(health_to_add: int) -> void:
	# Make sure we cannot overheal enemies.
	health = clampi(health + health_to_add, health, MAX_HP)


func is_dead() -> bool:
	return health <= 0
