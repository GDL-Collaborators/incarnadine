extends KinematicBody2D

class_name Pushable

signal pushed

export var grid_size = Vector2(32, 32)
export var weight = 30

# How long moving one grid space takes in seconds, based weight
onready var move_time = lerp(0.3, 2.2, clamp(weight / 100, 0, 1))
# How much the block has been pushed
var accumulated_force = Vector2.ZERO

# internal movement state
var movement = null
onready var original_transform = transform

func _player_hit(normal, force):
	if not movement:
		accumulated_force += -normal * force * 1.8

func _physics_process(delta):
	if abs(accumulated_force.x) > weight:
		move_one_grid_unit(Vector2(sign(accumulated_force.x), 0) * grid_size.x)
	elif abs(accumulated_force.y) > weight:
		move_one_grid_unit(Vector2(0, sign(accumulated_force.y)) * grid_size.y)

	if movement:
		movement.progress += delta / move_time
		position = movement.start.linear_interpolate(movement.end, min(movement.progress, 1))

		if movement.progress >= 1:
			emit_signal('pushed', movement.end)
			movement = null
	else:
		accumulated_force *= 0.99

func move_one_grid_unit(amount):
	var old_pos = position
	var hit = move_and_collide(amount)
	position = old_pos

	if !hit:
		movement = {
			'start': position,
			'end': position + amount,
			'progress': 0
		}

	accumulated_force = Vector2.ZERO

func reset():
	transform = original_transform
