extends Area2D
class_name Enemy

func _ready():
	connect('body_entered', self, 'touch_body')

func touch_body(body):
	if body.has_method('_hurt'):
		body.call('_hurt', self)
