extends Node2D

func _ready():
	GameUi.start_dialogue([
		{
			'name': '',
			'body': 'This will be the opening dialogue...'
		}
	])
	yield(GameUi, 'end_dialogue')
	GameState.next_level()
