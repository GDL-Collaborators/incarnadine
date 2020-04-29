extends Node2D

onready var dog = $YSort/Dog

func _ready():
	$'YSort/Reset Button'.connect('pressed', self, 'reset_puzzle')
	$UnlockArea.connect('body_entered', self, 'maybe_unlock')

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

	if $YSort/Player.position.x < 1050:
		$YSort/Player.position = $YSort/Entrance.position

func maybe_unlock(body):
	if body.is_in_group('player'):
		GameState.unlock_exit()
