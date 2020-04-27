extends StaticBody2D



func _interact(player):
	if not player.has_item('spectacles'):
		get_node('/root/GameUi').start_dialogue([
		{
			'portrait': 'OldCrone',
			'name': 'Old Crone',
			'body': "Hello little one, you haven't seen a pair of spectacles around here, have you? I was in a trance, meditating on the solution, when a spirit took over my body. When I came to, I was crouched in that corner over there, and my face was wet with tears...I suddenly knew the right order to activate the stones, but now I can't find my glasses. I'll tell you what--I'll make you a deal: If you can find them for me, I'll tell you the correct order." }])
	else:
		get_node('/root/GameUi').start_dialogue([
			{
				'portrait': 'OldCrone',
				'name': 'Old Crone',
				'body': "They were over there? Huh...I could have sworn I looked there thoroughly...how strange. Well, you've fulfilled your end of the deal, so now for my part: The correct order is: 'I, S, M, H, B'" }])
		player.rem_item('spectacles')

func _ready():
	pass 

