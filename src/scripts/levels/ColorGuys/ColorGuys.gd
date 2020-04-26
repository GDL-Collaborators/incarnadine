extends Node2D

func _ready():
	$FloodPuzzle.connect('complete', GameState, 'unlock_exit')
