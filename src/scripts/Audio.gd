extends Node

func play_sfx(sfx: AudioStream):
	var stream = AudioStreamPlayer.new()
	stream.stream = sfx
	get_tree().get_root().add_child(stream)
	stream.play()
	yield(stream, 'finished')
	stream.queue_free()
