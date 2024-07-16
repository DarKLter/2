extends Node2D

enum LedgeBehaviour{
	TURN_AROUND,
	WALK_OFF,
}

@export var _ledge_behaviour : LedgeBehaviour
@onready var _character : Character = get_parent()
@onready var _floor_ray : RayCast2D = $RayCast2D
var _direction : float

func _ready():
	_direction = -1 if _character.is_facing_left() else 1
	_set_floor_ray_position()

func _set_floor_ray_position():
	@warning_ignore("integer_division")
	_floor_ray.position.x = Global.ppt / 2 * _direction

func _process(_delta : float):
	if _character.is_on_wall():
		_direction = sign(_character.get_wall_normal().x)
		_set_floor_ray_position()
	if _character.is_on_floor() && not _floor_ray.is_colliding():
		_ledge_detected()
	_character.run(_direction)

func _ledge_detected():
	match _ledge_behaviour:
		LedgeBehaviour.TURN_AROUND:
			_direction *= -1
			_set_floor_ray_position()
		LedgeBehaviour.WALK_OFF:
			return
