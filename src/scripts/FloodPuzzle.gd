tool
extends Node2D

signal complete

export var tile_size = 32
export var size: Vector2 = Vector2(2, 2)

onready var is_editor = Engine.is_editor_hint()

export var red = Color(0.9, 0.1, 0.1)
export var green = Color(0.1, 0.9, 0.1)
export var blue = Color(0.1, 0.1, 0.9)

var tiles = []

func _ready():
	init_map()

func _process(_delta):
	if tiles.size() != size.y or tiles[0].size() != size.x:
		init_map()

	update()

var n = 0
func _input(event):
	if event is InputEventMouseButton:
		if event.pressed:
			match n % 3:
				0: fill(0, 0, red)
				1: fill(0, 0, green)
				2: fill(0, 0, blue)
			n += 1

func _draw():
	for y in range(0, tiles.size()):
		for x in range(0, tiles[y].size()):
			draw_rect(Rect2(x * tile_size, y * tile_size, tile_size, tile_size), tiles[y][x])

func init_map():
	tiles = []

	for y in range(0, size.y):
		var row = []

		for i in range(0, size.x):
			row.append(random_color())

		tiles.append(row)

func random_color():
	match randi() % 3:
		0: return red
		1: return green
		2: return blue

func fill(x, y, color):
	var open = [Vector2(x, y)]
	var closed = {}
	var oldcol = tiles[y][x]

	while open.size():
		var curr = open.front()
		var cx = curr.x
		var cy = curr.y

		if closed.has(str(curr.x) + ',' + str(curr.y)):
			open.pop_front()
			continue

		tiles[curr.y][curr.x] = color
		closed[str(curr.x) + ',' + str(curr.y)] = true
		open.pop_front()
		
		if cx > 0 and tiles[cy][cx - 1] == oldcol and !closed.has(str(cx - 1) + ',' + str(cy)):
			open.append(Vector2(cx - 1, cy))
		if cx < size.x - 1 and tiles[cy][cx + 1] == oldcol and !closed.has(str(cx + 1) + ',' + str(cy)):
			open.append(Vector2(cx + 1, cy))
		if cy > 0 and tiles[cy - 1][cx] == oldcol and !closed.has(str(cx) + ',' + str(cy - 1)):
			open.append(Vector2(cx, cy - 1))
		if cy < size.y - 1 and tiles[cy + 1][cx] == oldcol and !closed.has(str(cx) + ',' + str(cy + 1)):
			open.append(Vector2(cx, cy + 1))

		update()
		yield(get_tree().create_timer(0.01), 'timeout')

	if is_complete():
		emit_signal('complete')

func is_complete():
	var color = tiles[0][0]
	
	for y in range(0, tiles.size()):
		for x in range(0, tiles[y].size()):
			if tiles[y][x] != color:
				return false

	return true
