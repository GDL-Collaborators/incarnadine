tool
extends Sprite

class_name AnimatedAtlas

export(Array, Texture) var frames = []
export var frames_per_second: float = 5
export var repeat_delay: float = 0

var t = 0
var rt = 0

func _process(delta):
	if rt > 0:
		rt -= delta
		return

	t += delta
	
	var frame_time = 1.0 / frames_per_second
	var cycle_time = frame_time * frames.size()
	var frame = int(t / frame_time)
	
	if texture.atlas:
		texture.atlas = frames[frame % frames.size()]
		
	if t > cycle_time:
		rt = repeat_delay
		t -= cycle_time
