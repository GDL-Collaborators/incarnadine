extends StaticBody2D

func _interact(_player):
	get_node('/root/GameUi').start_dialogue([
	{
		'portrait': 'Floor',
		'name': 'Empty Floor',
		'body': "You search this corner and find only a few scratches on the wall. It's also eerily cold for no apparent reason. Just in this spot. Maybe you should start looking somewhere else..."
	}
	])

func _ready():
	pass

