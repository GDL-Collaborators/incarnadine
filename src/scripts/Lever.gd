extends StaticBody2D

signal flipped

export var on = false
var tex_left = preload('res://assets/lever/LeverL.png')
var tex_right = preload('res://assets/lever/LeverR.png')

func _ready():
	set_sprite()

var _interact_label = 'Flip Lever'
func _interact(_player):
	on = !on
	$AudioStreamPlayer2D.play()
	set_sprite()
	emit_signal('flipped', on)

func set_sprite():
	$Sprite.texture = tex_right if on else tex_left
