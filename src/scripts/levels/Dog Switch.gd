extends Node2D

var switches = {
	'left': false,
	'right': false
}
var solved = false

func _ready():
	$'YSort/Step Button'.connect('toggled', self, 'left_switch_toggle')
	$'YSort/Step Button2'.connect('toggled', self, 'right_switch_toggle')

func left_switch_toggle(state):
	if not solved:
		switches.left = state
		check_solved()

func right_switch_toggle(state):
	if not solved:
		switches.right = state
		check_solved()

func check_solved():
	if switches.left and switches.right:
		solved = true

		for switch in get_tree().get_nodes_in_group('dog_switches'):
			switch.locked = true
			
		GameState.unlock_exit()
		get_tree().get_nodes_in_group('dog').front().follow_player()
