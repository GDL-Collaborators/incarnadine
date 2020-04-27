extends Area2D

enum Variation {
	One,
	Two,
	Three
}

export(Variation) var variation = Variation.One

func _interact(_player):
	match variation:
		Variation.One:
			get_node('/root/GameUi').start_dialogue([
			{
				'portrait': 'Floor',
				'name': '',
				'body': "You search this corner and find only a few scratches on the wall. It's also eerily cold for no apparent reason. Just in this spot. Maybe you should start looking somewhere else..."
			}
			])
		Variation.Two:
			get_node('/root/GameUi').start_dialogue([
			{
				'portrait': 'Floor',
				'name': '',
				'body': "Nothing but cob webs and broken rocks in this corner..."
			}
			])
		Variation.Three:
			get_node('/root/GameUi').start_dialogue([
			{
				'portrait': 'Floor',
				'name': '',
				'body': "You run your hands through the dust and find some old rat bones and scraps of fabric. Nothing interesting here."
			}
			])

func _ready():
	pass

