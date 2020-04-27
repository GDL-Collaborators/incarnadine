extends StaticBody2D

signal mannaz

var activate = preload('res://assets/sfx/activate1.wav')

func _interact(_player):
	Audio.play_sfx(activate)
	emit_signal("mannaz")

func _ready():
	pass 
