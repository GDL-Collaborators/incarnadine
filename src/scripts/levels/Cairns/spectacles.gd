extends Area2D

var _interact_label = 'Lost Spectacles'

func _interact(player):
	GameUi.start_dialogue([
		{
			'portrait': 'Floor',
			'name': '',
			'body': "You found a pair of dusty old spectacles among the debris on the floor. You put them in your pocket."
		}
	])
	player.add_item('spectacles', 'Spectacles')
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
