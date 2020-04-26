extends StaticBody2D

func _interact(player):
	player.rem_item('paintr')
	player.rem_item('paintg')
	player.rem_item('paintb')
	player.add_item('paintr', 'RedPaint')
