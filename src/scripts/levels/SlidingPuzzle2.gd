extends Node2D

onready var dog = $YSort/Dog

func _ready():
	$'YSort/Reset Button'.connect('pressed', self, 'reset_puzzle')
	$'YSort/Button1'.connect('pressed', self, 'open_first_door')
	$'YSort/Button2'.connect('pressed', self, 'open_second_door')

	for obj in $YSort.get_children():
		if obj.name.begins_with('PushBlockSm'):
			obj.connect('pushed', self, 'maybe_unlock')

	dog.stay($WaitSpot.position)
	GameUi.set_dog_label('Reset')

func _unhandled_input(event):
	if event.is_pressed() and event.is_action('dog'):
		dog.stay($'YSort/Reset Button'.position + Vector2(0, 7))
		yield(get_tree().create_timer(1.0), 'timeout')
		dog.stay($WaitSpot.position)

func reset_puzzle():
	for obj in $YSort.get_children():
		if obj.name.begins_with('PushBlock'):
			obj.reset()

	if $YSort/Player.position.y > 100:
		$YSort/Player.position = $YSort/Entrance.position

func open_first_door():
	$Door1.queue_free()

func open_second_door():
	$Door2.queue_free()

func maybe_unlock(position: Vector2):
	if position.x == 960 && position.y == 832:
		$YSort/Door3.queue_free()
		GameState.unlock_exit()
