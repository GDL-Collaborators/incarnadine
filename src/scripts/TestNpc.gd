extends StaticBody2D

func _interact(_player):
	get_node('/root/GameUi').start_dialogue([
	{
		'name': 'Someone',
		'body': 'Hey this is a pretty sweet dialogue box huh?'
	},
	{
		'name': 'Someone',
		'body': "But wait, there's more!"
	}
	])
