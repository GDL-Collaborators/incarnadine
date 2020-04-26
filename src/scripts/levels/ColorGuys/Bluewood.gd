extends StaticBody2D

var dialogue = {
	'never met': [
		{
			'name': '???',
			'portrait': 'Bluewood',
			'body': 'Oh hey there little dude, are you stuck here too? Bogus, man. These other two dudes are too wound up to work together.'
		},
		{
			'body': "But hey, you know what? Blue is a pretty chill color, why don't you give this a try and you'll probably feel better."
		},
		{
			'name': 'Bluewood',
			'body': "You should check out the Kingdom of Blue some time. It's a great placed full of the stuff. Oh! I'm Bluewood by the way, but you can just call me Blue."
		}
	],
	'second encounter': [
		{
			'name': 'Bluewood',
			'portrait': 'Bluewood',
			'body': "Hey man, you're totally colorless. That's a trip dude. I'm Bluewood, nice to meet'cha."
		},
		{
			'body': "Think you can handle some pure blue, dude? It's pretty radical, but I promise you'll like it. Here, it's on me. I've got tons of the stuff."
		}
	],
	'third encounter': [
		{
			'name': 'Bluewood',
			'portrait': 'Bluewood',
			'body': "Back for more little dude? You're cool man. Take as much as you want, don't even ask."
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
	player.add_item('paintb', 'BluePaint')
