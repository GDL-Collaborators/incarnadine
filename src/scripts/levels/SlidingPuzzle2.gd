extends Node2D

var test: Node2D

func _ready():
	$'YSort/Reset Button'.connect('pressed', self, 'reset_puzzle')
	$'YSort/Button1'.connect('pressed', self, 'open_first_door')
	$'YSort/Button2'.connect('pressed', self, 'open_second_door')

	for obj in $YSort.get_children():
		if obj.name.begins_with('PushBlockSm'):
			obj.connect('pushed', self, 'maybe_unlock')

func reset_puzzle():
	for obj in $YSort.get_children():
		if obj.name.begins_with('PushBlock'):
			obj.reset()

func open_first_door():
	$Door1.queue_free()

func open_second_door():
	$Door2.queue_free()

func maybe_unlock(position: Vector2):
	if position.x == 960 && position.y == 832:
		$YSort/Door3.queue_free()
		GameState.unlock_exit()
