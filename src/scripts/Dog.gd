extends RigidBody2D

var speed = 225
var velocity = Vector2.ZERO
var idle_timer = 1
var follow_distance = 50
var follow_timer = 1
var follow_trail = []

enum State { FOLLOW, SIT }
var state = State.FOLLOW

onready var player = get_tree().get_nodes_in_group('player').front()
onready var sprite: AnimatedSprite = $AnimatedSprite
onready var target = player

# Commands
func follow(who: Node):
	follow_trail = []
	target = who
	state = State.FOLLOW
	$'/root/GameUi'.set_dog_label('Sit')

func follow_player():
	follow(player)

func sit():
	state = State.SIT
	$'/root/GameUi'.set_dog_label('Follow')

# Implementation
func _physics_process(delta):
	var target_speed = Vector2.ZERO

	match state:
		State.FOLLOW:
			follow_timer -= delta
			target_speed = determine_follow_velocity()
			
			velocity = velocity.linear_interpolate(target_speed, 0.5)
			linear_velocity = velocity
		State.SIT:
			linear_velocity *= 0.5

	rotation = 0
	angular_velocity = 0
		
	idle_timer -= delta
	pick_animation(target_speed if target_speed.length() > 4 else position.direction_to(target.position))

func pick_animation(direction):
	match state:
		State.FOLLOW:
			if velocity.length() > 0.1:
				sprite.animation = 'run'
				sprite.speed_scale = lerp(1, 2.5, linear_velocity.length() / speed)
				sprite.flip_h = direction.x >= 0

				reset_idle()
			else:
				if idle_timer < -2:
					reset_idle()
				elif idle_timer <= 0:
					sprite.animation = 'idle1'
				else:
					sprite.animation = 'stand'
		State.SIT:
			sprite.animation = 'run' if linear_velocity.length() > 5 else 'sit'
			sprite.flip_h = direction.x >= 0

var frames = 0
func determine_follow_velocity():
	frames += 1
	
	if frames % 6 == 0:
		if not follow_trail.front() or target.position.distance_to(follow_trail.front()) > 1:
			follow_trail.push_front(target.position)
			
	var ray_hit = get_world_2d().direct_space_state.intersect_ray(position, target.position, [self, target])

	if ray_hit:
		if follow_trail.size() and position.distance_to(follow_trail.back()) < 10:
			follow_trail.pop_back()
	elif follow_trail.size() > 2:
		follow_trail.resize(2)

	if follow_timer <= 0:
		adjust_follow_distance()

	if position.distance_to(target.position) > follow_distance:
		var point = follow_trail.back() if ray_hit and follow_trail.size() else target.position
		return position.direction_to(point) * speed
	else:
		return Vector2.ZERO

func adjust_follow_distance():
	follow_distance = rand_range(50, 100)
	follow_timer = rand_range(1.5, 4)

func reset_idle():
	idle_timer = rand_range(1.5, 4)
