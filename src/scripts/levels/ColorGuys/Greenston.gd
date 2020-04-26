extends StaticBody2D

var dialogue = {
	'never met': [
		{
			'name': 'Greenston',
			'portrait': 'Greenston',
			'body': 'Sir Greenston of the mighty Kingdom of Green, at your service.'
		},
		{
			'body': "Humm. I don't rightly recall seeing your type before. Are you lost, little colorless one?"
		},
		{
			'body': "Such a pity! Normally my code of honor would compel me to return you home but alas, I seem to be somewhat confounded myself. We appear to have made a mess of this board."
		},
		{
			'body': 'At any rate, the least I can do is solve your tragic lack of color. Here, take this pale of elegant Green and do not fret!'
		}
	],
	'second encounter': [
		{
			'name': '???',
			'portrait': 'Greenston',
			'body': "So those rapscalions have tried to fill your head with their nonsense, have they? Thank goodness you haven't yet fallen for their trap, colorless one."
		},
		{
			'name': 'Greenston',
			'body': "Allow your friend Sir Greenston to provide you with the greatest color in all the kingdoms. No, no, there's no need to thank me, just take it!"
		}
	],
	'third encounter': [
		{
			'name': 'Greenston',
			'portrait': 'Greenston',
			'body': 'So you acknowledge the rightful place of Green above the lesser colors. Very good, take as much as you like!'
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
	player.add_item('paintg', 'GreenPaint')
