extends RigidBody2D

var speed = 225
var velocity = Vector2.ZERO
var idle_timer = 1
var follow_distance = 50
var follow_timer = 1

enum State { FOLLOW, SIT }
var state = State.FOLLOW

onready var player = get_tree().get_nodes_in_group('player').front()
onready var sprite: AnimatedSprite = $AnimatedSprite
onready var target = player

# Commands
func follow(who: Node):
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
	var target_speed

	match state:
		State.FOLLOW:
			follow_timer -= delta
			if follow_timer <= 0:
				adjust_follow_distance()

			if position.distance_to(target.position) > follow_distance:
				target_speed = position.direction_to(target.position) * speed
			else:
				target_speed = Vector2.ZERO
			
			velocity = velocity.linear_interpolate(target_speed, 0.5)
			linear_velocity = velocity
		State.SIT:
			linear_velocity *= 0.5

	rotation = 0
	angular_velocity = 0
		
	idle_timer -= delta
	pick_animation()

func pick_animation():
	match state:
		State.FOLLOW:
			if velocity.length() > 0.1:
				sprite.animation = 'run'
				sprite.speed_scale = lerp(1, 2.5, linear_velocity.length() / speed)
				sprite.flip_h = position.direction_to(target.position).x >= 0

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
			sprite.flip_h = position.direction_to(target.position).x >= 0

func adjust_follow_distance():
	follow_distance = rand_range(50, 100)
	follow_timer = rand_range(1.5, 4)

func reset_idle():
	idle_timer = rand_range(1.5, 4)
