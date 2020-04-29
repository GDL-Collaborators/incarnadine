extends CanvasLayer

signal end_dialogue
signal select_item

var item_scene = preload('res://ui/InventoryItem.tscn')
var item_icons = {
	'Wrench': preload('res://assets/items/Wrench.png'),
	'RedPaint': preload('res://assets/items/RedPaint.png'),
	'BluePaint': preload('res://assets/items/BluePaint.png'),
	'GreenPaint': preload('res://assets/items/GreenPaint.png'),
	'Sword': preload('res://assets/items/Sword.png'),
	'Spectacles': preload('res://assets/items/spectacles.png')
}
var items: Array = []

onready var popup_grid = $PopupInventory/CenterContainer/PanelContainer/MarginContainer/VBoxContainer/Grid

func _ready():
	$DialogueBox.visible = false
	$PopupInventory.visible = false
	update_keybinds()

func _input(event):
	if event.is_action('up'):
		Input.parse_input_event(make_input_event('ui_up', event.is_pressed()))
	elif event.is_action('down'):
		Input.parse_input_event(make_input_event('ui_down', event.is_pressed()))
	elif event.is_action('left'):
		Input.parse_input_event(make_input_event('ui_left', event.is_pressed()))
	elif event.is_action('right'):
		Input.parse_input_event(make_input_event('ui_right', event.is_pressed()))
	elif event.is_action('interact'):
		Input.parse_input_event(make_input_event('ui_select', event.is_pressed()))
		Input.parse_input_event(make_input_event('ui_accept', event.is_pressed()))
	elif event.is_action('dog'):
		Input.parse_input_event(make_input_event('ui_cancel', event.is_pressed()))

func update_keybinds():
	$Controls/DogKey.text = get_input_name(InputMap.get_action_list('dog').front())
	$Controls/InteractKey.text = get_input_name(InputMap.get_action_list('interact').front())

func make_input_event(name, pressed):
	var event = InputEventAction.new()
	event.action = name
	event.pressed = pressed
	return event

var button_names = [
	'(A)',
	'(B)',
	'(X)',
	'(Y)',
	'(L)',
	'(R)',
	'(L2)',
	'(R2)',
	'(L3)',
	'(R3)',
	'◀',
	'▶',
	'↑',
	'↓',
	'←',
	'→'
]
func get_input_name(event):
	if event is InputEventKey:
		return event.as_text()
	if event is InputEventJoypadButton:
		return button_names[event.button_index]
	if event is InputEventJoypadMotion:
		return str(event.axis) + ('+' if event.axis_value >= 0 else '-')
	if event is InputEventMouseButton:
		return 'M' + str(event.button_index)

	return '?'

func start_dialogue(tree):
	get_tree().paused = true
	$DialogueBox.set_tree(tree)
	$Controls.visible = false
	$DialogueBox.visible = true

func end_dialogue():
	$DialogueBox.visible = false
	$Controls.visible = true
	get_tree().paused = false
	emit_signal('end_dialogue')

func add_item(id, icon):
	var main_icon: Control = item_scene.instance()
	main_icon.get_node('TextureRect').texture = item_icons.get(icon, null)
	var popup_icon = main_icon.duplicate()
	main_icon.focus_mode = Control.FOCUS_NONE

	var item = {
		'id': id,
		'main_icon': main_icon,
		'popup_icon': popup_icon
	}
	items.append(item)

	popup_icon.connect('pressed', self, 'pick_item', [item])

	$Inventory/Grid.add_child(main_icon)
	popup_grid.add_child(popup_icon)

func rem_item(id):
	for item in items:
		if item.id == id:
			item.main_icon.queue_free()
			item.popup_icon.queue_free()
			items.erase(item)
			break

func reset_items():
	for item in items:
		rem_item(item.id)

	items.clear()

func popup_inventory():
	if items.empty():
		return

	get_tree().paused = true
	$PopupInventory.visible = true
	items.front().popup_icon.grab_focus()

func pick_item(item):
	emit_signal('select_item', item.id)
	get_tree().paused = false
	$PopupInventory.visible = false

func disable():
	for item in get_children():
		item.visible = false

func enable():
	for item in get_children():
		item.visible = true
	$DialogueBox.visible = !!$DialogueBox.tree
	$PopupInventory.visible = false

func set_interact_label(value):
	if value:
		$Controls/InteractLabel.text = value
	else:
		$Controls/InteractLabel.text = 'Interact'

func set_dog_label(value):
	if value:
		$Controls/DogLabel.text = value
		$Controls/DogLabel.visible = true
		$Controls/DogKey.visible = true
		$Controls/DogTex.visible = true
	else:
		$Controls/DogLabel.visible = false
		$Controls/DogKey.visible = false
		$Controls/DogTex.visible = false
