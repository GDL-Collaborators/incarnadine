extends Control

var tree = []
var current_item = 0

onready var dialogue_portrait: Label = $MarginContainer/HBoxContainer/VBoxContainer/ColorRect/Portrait
onready var dialogue_name: Label = $MarginContainer/HBoxContainer/VBoxContainer/MarginContainer/Label
onready var dialogue_body: Label = $MarginContainer/HBoxContainer/VBoxContainer2/Label2
onready var dialogue_next: Label = $MarginContainer/HBoxContainer/VBoxContainer2/Button

var portraits = {
	'Default': preload('res://assets/portraits/Default.png'),
	'Beggar': preload('res://assets/portraits/Beggar.png'),
	'Redmond': preload('res://assets/portraits/Redmond.png'),
	'Bluewood': preload('res://assets/portraits/Bluewood.png'),
	'Greenston': preload('res://assets/portraits/Greenston.png'),
	'OldCrone': preload('res://assets/portraits/OldCrone.png'),
}

func _input(_event):
	if Input.is_action_just_pressed('interact') and self.visible:
		get_tree().set_input_as_handled()
		advance()

func set_tree(items):
	tree = items
	current_item = 0
	dialogue_portrait.texture = portraits['Default']
	read_item()

func read_item():
	if current_item >= tree.size():
		GameUi.end_dialogue()
		tree = null
	else:
		var item = tree[current_item]
		
		dialogue_body.text = item.body
		
		if item.has('name'):
			dialogue_name.text = item.name

		if item.has('portrait') and portraits.has(item.portrait):
			dialogue_portrait.texture = portraits[item.portrait]

		dialogue_next.visible = current_item + 1 < tree.size()

func advance():
	current_item += 1
	read_item()
