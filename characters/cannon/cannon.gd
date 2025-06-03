class_name Cannon
extends Node

enum CannonType {
	DEFAULT,
	FIRE,
	WATER,
	WIND,
	EARTH
}

const CANNON_BALL_GRAVITY: float = 9.1
const CANNON_BALL_VELOCITY: float = 1000.0
const CANNON_BALL_MASS: float = 8.0

var cannon_type: CannonType = CannonType.DEFAULT
var aim_coordinates: Vector2
