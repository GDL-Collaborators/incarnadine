extends StaticBody2D

var active = false

func _ready():
	$Magic.visible = false
	
func activate():
	$Magic.visible = true
	active = true
	
func deactivate():
	$Magic.visible = false
	active = false

func _on_Area2D_body_entered(body: PhysicsBody2D):
	if active:
		if body and body.is_in_group('player'):
			GameState.next_level()
