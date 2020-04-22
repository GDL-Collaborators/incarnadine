extends Area2D

signal toggled
signal pressed
signal released

export var one_shot = false

var locked = false

func _ready():
	connect('body_entered', self, 'step_on')
	connect('body_exited', self, 'step_off')

func step_on(body):
	if locked:
		return
		
	if body.is_in_group('step_button'):
		if not $StepButtonDn.visible:
			$AudioStreamPlayer2D.play()

		$StepButtonUp.visible = false
		$StepButtonDn.visible = true
		emit_signal('toggled', true)
		emit_signal('pressed')
		
func step_off(original_body):
	if locked or one_shot:
		return

	for body in get_overlapping_bodies():
		if body.is_in_group('step_button') and body != original_body:
			return

	$StepButtonUp.visible = true
	$StepButtonDn.visible = false
	emit_signal('toggled', false)
	emit_signal('released')
	$AudioStreamPlayer2D.play()
		
