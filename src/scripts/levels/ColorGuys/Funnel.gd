extends StaticBody2D

func _interact(player):
	if player.has_item('paintr'):
		player.rem_item('paintr')
		owner.get_node('FloodPuzzle').fill_color('red')
	if player.has_item('paintg'):
		player.rem_item('paintg')
		owner.get_node('FloodPuzzle').fill_color('green')
	if player.has_item('paintb'):
		player.rem_item('paintb')
		owner.get_node('FloodPuzzle').fill_color('blue')
