extends StaticBody2D

var dialogue = {
	'never met': [
		{
			'name': 'Redmond',
			'portrait': 'Redmond',
			'body': 'Peasant! Serf! How dare you approach the great Duke Redmond of the Kingdom of Red without displaying the One True Color?'
		},
		{
			'body': "...I can see you're ignorant of the gravity of your mistake so I'll let you off the hook this one time."
		},
		{
			'body': "Take this and don't speak to me again unless you're showing the Color. I have to figure out how to fix those idiots mistakes with this board."
		}
	],
	'second encounter': [
		{
			'name': '???',
			'portrait': 'Redmond',
			'body': 'Argh! That-- you-- *huff*'
		},
		{
			'name': 'Redmond',
			'body': "You're lucky the great Duke Redmond douse you where you stand. The nerve of you to acknowledge those false colors!"
		},
		{
			'body': "I'll give you one chance to correct this mistake. Take this and renounce those inferior colors."
		}
	],
	'third encounter': [
		{
			'name': 'Redmond',
			'portrait': 'Redmond',
			'body': "I see that you're a back stabbing little rat, but I suppose as long as you acknowledge the One True Color I'll tolerate it."
		}
	]
}

var interacted = 0

func _interact(player):
	if not player.has_flag('colorguys'):
		GameUi.start_dialogue(dialogue['never met'])
		player.set_flag('colorguys', true)
		interacted = 1
		yield(GameUi, 'end_dialogue')
		give_item(player)
	elif interacted == 0:
		GameUi.start_dialogue(dialogue['second encounter'])
		interacted = 1
		yield(GameUi, 'end_dialogue')
		give_item(player)
	elif interacted == 1:
		GameUi.start_dialogue(dialogue['third encounter'])
		interacted = 2
		yield(GameUi, 'end_dialogue')
		give_item(player)
	else:
		give_item(player)

func give_item(player):
	player.rem_item('paintr')
	player.rem_item('paintg')
	player.rem_item('paintb')
	player.add_item('paintr', 'RedPaint')
