extends StaticBody2D

var splat_sound = preload('res://assets/sfx/squish.wav')

func _interact(player):
	if player.has_item('paintr'):
		player.rem_item('paintr')
		Audio.play_sfx(splat_sound)
		owner.get_node('FloodPuzzle').fill_color('red')
	if player.has_item('paintg'):
		player.rem_item('paintg')
		Audio.play_sfx(splat_sound)
		owner.get_node('FloodPuzzle').fill_color('green')
	if player.has_item('paintb'):
		player.rem_item('paintb')
		Audio.play_sfx(splat_sound)
		owner.get_node('FloodPuzzle').fill_color('blue')
