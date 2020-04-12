extends StaticBody2D

func _interact(_player):
	get_node('/root/GameUi').start_dialogue([
	{
		'portrait': 'Beggar',
		'name': 'Old Man',
		'body': "You there, lively young lad. Won't you help a poor old man?"
	},
	{
		'portrait': 'Beggar',
		'name': 'Old Man',
		'body': "I've been trapped in this tower for oh so long. I came here to slay the evil master, but I could never defeat the guardian of this floor."
	},
	{
		'portrait': 'Beggar',
		'name': 'Old Man',
		'body': "Take my sword. You may keep it, my body is too old and frail to hold it any longer. I ask only that you free me from this trap if you can."
	}
	])
