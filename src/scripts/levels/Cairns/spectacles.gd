extends StaticBody2D

var _interact_label = 'Lost Spectacles'

func _interact(player):
	player.add_item('spectacles', 'spectacles')
	queue_free()

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
