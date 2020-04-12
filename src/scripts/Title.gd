extends Node2D

onready var main_menu = get_tree().get_nodes_in_group('main_menu').front()
onready var options_menu = get_tree().get_nodes_in_group('options_menu').front()

func _ready():
	main_menu.get_node('Button').connect('pressed', self, 'start_clicked')
	main_menu.get_node('Button2').connect('pressed', self, 'options_clicked')
	main_menu.get_node('Button3').connect('pressed', self, 'exit_clicked')
	
	options_menu.get_node('Button').connect('pressed', self, 'return_to_main')
	options_menu.get_node('CheckButton').connect('toggled', self, 'animation_effect_toggle')

	return_to_main()
	$'/root/GameUi'.disable()

func start_clicked():
	get_node('/root/GameState').start_game()
	get_node('/root/GameUi').enable()

func options_clicked():
	main_menu.visible = false
	options_menu.visible = true

func return_to_main():
	main_menu.visible = true
	options_menu.visible = false

func exit_clicked():
	get_tree().quit()

func animation_effect_toggle(state):
	get_node('/root/GameState').use_animation_effect = state
