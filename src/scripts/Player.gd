extends KinematicBody2D

var acceleration = 0.4
var deceleration = 0.75
var max_speed = 250

var velocity = Vector2.ZERO
var direction = 'down'
var walk_frame = 0
var interactables = []
var items = []
var attacking = false
var flags = {}

onready var activator: KinematicBody2D = $ActivateBox
onready var dog = get_tree().get_nodes_in_group('dog').front()

func _process(_delta):
	var input = get_input_vector()
	var target_speed = input * max_speed

	velocity = velocity.linear_interpolate(target_speed, acceleration if velocity.length() < target_speed.length() else deceleration)

	pick_animation()

	$HeyListen.visible = interactables.size() > 0

	# Melee
	if target_speed.length() > 1:
		$Weapon/Hitbox.rotation = target_speed.angle()

func _physics_process(_delta):
	# Movement
	velocity = move_and_slide(velocity)

	for i in range(0, get_slide_count()):
		var hit = get_slide_collision(i)

		if hit.collider.has_method('_player_hit'):
			hit.collider.call('_player_hit', hit.normal, hit.remainder.length())

	# Interaction
	interactables = []

	for thing in activator.get_overlapping_bodies():
		if thing.has_method('_interact'):
			interactables.append(thing)

	for thing in activator.get_overlapping_areas():
		if thing.has_method('_interact'):
			interactables.append(thing)

	# Interaction UI
	if not interactables.empty():
		GameUi.set_interact_label(interactables.front().get('_interact_label'))
	else:
		GameUi.set_interact_label(null)

func _unhandled_input(_event):
	if Input.is_action_just_pressed('interact'):
		if not interactables.empty():
			interactables.front()._interact(self)
		elif has_weapon():
			melee_attack()

	if Input.is_action_just_pressed('dog'):
		match dog.state:
			dog.State.FOLLOW:
				dog.sit()
			dog.State.SIT:
				dog.follow(self)

func _hurt():
	pass

func melee_attack():
	$Weapon/Hitbox/Effect.visible = true
	for thing in $Weapon/Hitbox.get_overlapping_bodies():
		if thing.has_method('_hit'):
			thing.call('_hit')

	yield(get_tree().create_timer(0.25), 'timeout')
	$Weapon/Hitbox/Effect.visible = false

func add_item(id, icon):
	items.append(id)
	GameUi.add_item(id, icon)

func has_item(id):
	return items.find(id) != -1

func rem_item(id):
	items.erase(id)
	GameUi.rem_item(id)

func clear_inventory():
	for item in items:
		rem_item(item)

	items.clear()

func has_weapon():
	return has_item('sword')

func has_flag(name):
	return flags.has(name)

func set_flag(name, value):
	flags[name] = value

func clear_flags():
	flags.clear()

func pick_animation():
	var horizontal = abs(velocity.x) > abs(velocity.y)
	var sprite: AnimatedSprite = $AnimatedSprite
	var last_anim = sprite.animation

	if velocity.length() > 1:
		if horizontal:
			direction = 'right' if velocity.x > 0 else 'left'
		else:
			direction = 'down' if velocity.y > 0 else 'up'
			
		sprite.animation = 'walk_' + direction
		
		if !last_anim.begins_with('walk_'):
			sprite.frame = walk_frame
		else:
			walk_frame = sprite.frame
	else:
		sprite.animation = direction


	sprite.speed_scale = lerp(1, 2.5, velocity.length() / max_speed)

func get_input_vector():
	return Vector2(
		int(Input.is_action_pressed('right')) - int(Input.is_action_pressed('left')),
		int(Input.is_action_pressed('down')) - int(Input.is_action_pressed('up'))
	).normalized()
