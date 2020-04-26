extends Node

# Levels
var levels = [
	preload('res://levels/Interaction.tscn'),
	preload('res://levels/Card Flipping.tscn'),
	preload('res://levels/Dog Switch.tscn'),
	preload('res://levels/SlidingPuzzle1.tscn'),
	preload('res://levels/SlidingPuzzle2.tscn'),
]
var title_scene = preload('res://Title.tscn')
var final_scene = preload('res://Final.tscn')
var current_level = 0
var level_solved = false

# Options
var use_animation_effect = true setget animation_effect_toggle

# Misc
var sprite_material = preload('res://vfx/material/AnimatedMat.tres')
var canvas_material = preload('res://vfx/material/CanvasAnimatedMat.tres')
var solved_sfx = preload('res://assets/sfx/solved.wav')
onready var viewport = get_tree()

func _ready():
	# For debug purposes attempt to find the active scene
	var level_names = []

	for level in levels:
		var inst = level.instance()
		level_names.append(inst.name)

	var index = level_names.find(get_tree().current_scene.name)

	if index != -1:
		current_level = index

	apply_animation_effect()

func start_game():
	get_tree().change_scene_to(levels[0])

func lock_exit():
	var portal = get_tree().get_nodes_in_group('portal').front()
	portal.deactivate()

func unlock_exit():
	var portal = get_tree().get_nodes_in_group('portal').front()
	portal.activate()

	# First time only
	if not level_solved:
		level_solved = true

		var stream = AudioStreamPlayer.new()
		stream.stream = solved_sfx
		get_tree().get_root().add_child(stream)
		stream.play()

		yield(stream, 'finished')
		stream.queue_free()

func next_level():
	GameUi.reset_items()
	current_level += 1
	level_solved = false

	get_tree().disconnect('tree_changed', self, 'apply_animation_effect')

	if current_level < levels.size():
		get_tree().change_scene_to(levels[current_level])
		apply_animation_effect()
	else:
		get_tree().change_scene_to(final_scene)
		apply_animation_effect()

	get_tree().connect('tree_changed', self, 'apply_animation_effect')

func animation_effect_toggle(state):
	use_animation_effect = state

	apply_animation_effect()

func apply_animation_effect():
	# Quitting
	if not get_tree():
		return

	for item in get_tree().get_nodes_in_group('use_canvas_effect'):
		if use_animation_effect:
			if not item.material:
				item.material = canvas_material
		else:
			if item.material == canvas_material:
				item.material = null
			
	for item in get_tree().get_nodes_in_group('use_sprite_effect'):
		if use_animation_effect:
			if not item.material:
				item.material = sprite_material
		else:
			if item.material == sprite_material:
				item.material = null
