extends Control

var tree = []
var current_item = 0

onready var dialogue_portrait: Label = $MarginContainer/HBoxContainer/VBoxContainer/ColorRect/Portrait
onready var dialogue_name: Label = $MarginContainer/HBoxContainer/VBoxContainer/MarginContainer/Label
onready var dialogue_body: Label = $MarginContainer/HBoxContainer/VBoxContainer2/Label2
onready var dialogue_next: Label = $MarginContainer/HBoxContainer/VBoxContainer2/Button

var portraits = {}

func _ready():
	var folder: Directory = Directory.new()
	
	folder.open('res://assets/portraits')
	folder.list_dir_begin(true, true)
	
	var file = folder.get_next()
	while file:
		if file.ends_with('.png'):
			var name = file.trim_suffix('.png')
			portraits[name] = load('res://assets/portraits/' + file)
		file = folder.get_next()

	folder.list_dir_end()

func _input(_event):
	if Input.is_action_just_pressed('interact') and self.visible:
		get_tree().set_input_as_handled()
		advance()

func set_tree(items):
	tree = items
	current_item = 0
	read_item()

func read_item():
	if current_item >= tree.size():
		get_node('/root/GameUi').end_dialogue()
		tree = null
	else:
		var item = tree[current_item]
		
		dialogue_name.text = item.name
		dialogue_body.text = item.body

		if item.has('portrait') and portraits.has(item.portrait):
			dialogue_portrait.texture = portraits[item.portrait]
		else:
			dialogue_portrait.texture = portraits['Default']

		dialogue_next.visible = current_item + 1 < tree.size()

func advance():
	current_item += 1
	read_item()
