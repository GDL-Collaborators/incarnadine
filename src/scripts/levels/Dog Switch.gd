extends Node2D

var switches = {
	'left': false,
	'right': false
}
var solved = false

onready var dog = get_tree().get_nodes_in_group('dog').front()
onready var player = get_tree().get_nodes_in_group('player').front()
onready var buttons = [
	$'YSort/Step Button',
	$'YSort/Step Button2'
]

func _ready():
	buttons[0].connect('toggled', self, 'left_switch_toggle')
	buttons[1].connect('toggled', self, 'right_switch_toggle')
	GameUi.set_dog_label('Sit')

func _unhandled_input(event):
	if event.is_pressed() and event.is_action('dog'):
		if dog.state == dog.State.FOLLOW:
			for button in buttons:
				if dog.position.distance_to(button.position) < 50:
					print('near button')
					dog.stay(button.position + Vector2(0, 7))

			if dog.state == dog.State.FOLLOW:
				dog.sit()

			GameUi.set_dog_label('Follow')
		else:
			dog.follow(player)
			GameUi.set_dog_label('Sit')

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
