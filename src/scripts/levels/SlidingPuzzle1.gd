extends Node2D

var test: Node2D

func _ready():
	$'/root/GameState'.unlock_exit()
	$'YSort/Step Button'.connect('pressed', self, 'reset_puzzle')

func reset_puzzle():
	for obj in $YSort.get_children():
		if obj.name.begins_with('PushBlock'):
			obj.reset()
