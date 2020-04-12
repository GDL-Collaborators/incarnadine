extends CanvasLayer

var item_scene = preload('res://ui/InventoryItem.tscn')
var item_icons = {}
var items = {}

func _ready():
	$DialogueBox.visible = false

	var folder: Directory = Directory.new()
	
	folder.open('res://assets/items')
	folder.list_dir_begin(true, true)
	
	var file = folder.get_next()
	while file:
		if file.ends_with('.png'):
			var name = file.trim_suffix('.png')
			item_icons[name] = load('res://assets/items/' + file)
		file = folder.get_next()

	folder.list_dir_end()

func start_dialogue(tree):
	get_tree().paused = true
	$DialogueBox.set_tree(tree)
	$DialogueBox.visible = true
	
func end_dialogue():
	$DialogueBox.visible = false
	get_tree().paused = false

func add_item(id, icon):
	var item_icon = item_scene.instance()
	item_icon.get_node('Panel/TextureRect').texture = item_icons.get(icon, null)
	items[id] = item_icon
	$Control/Inventory.add_child(item_icon)

func rem_item(id):
	if items.has(id):
		items[id].free()
		items.erase(id)

func disable():
	for item in get_children():
		item.visible = false

func enable():
	for item in get_children():
		item.visible = true
	$DialogueBox.visible = !!$DialogueBox.tree

func set_interact_label(value):
	if value:
		$Controls/InteractLabel.text = value
	else:
		$Controls/InteractLabel.text = 'Interact'
	
func set_dog_label(value):
	$Controls/DogLabel.text = value
