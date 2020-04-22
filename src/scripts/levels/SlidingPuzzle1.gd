extends Node2D

func _ready():
	$'YSort/Reset Button'.connect('pressed', self, 'reset_puzzle')
	$UnlockArea.connect('body_entered', self, 'maybe_unlock')

func reset_puzzle():
	for obj in $YSort.get_children():
		if obj.name.begins_with('PushBlock'):
			obj.reset()

func maybe_unlock(body):
	if body.is_in_group('player'):
		GameState.unlock_exit()
