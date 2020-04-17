tool
extends Sprite

class_name AnimatedAtlas

export(Array, Texture) var frames = []
export var frames_per_second: float = 5
export var repeat_delay: float = 0

func _process(_delta):
	var t = OS.get_ticks_msec() / 1000.0
	
	var frame_time = 1.0 / frames_per_second
	var cycle_time = frame_time * frames.size()
	var ct = fmod(t, cycle_time + repeat_delay)
	
	var frame = 0 if ct >= cycle_time else int(ct / frame_time)
	
	if texture.atlas:
		texture.atlas = frames[frame]
