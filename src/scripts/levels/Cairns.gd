extends Node2D


var _solution_array = ['isaz', 'sowilo', 'mannaz', 'hagalaz', 'berkanan']

var _player_array = []

func _on_CairnMannaz_mannaz():
	_player_array.push_back('mannaz')
	_test()
	_check_if_done()

func _on_CairnHagalaz_hagalaz():
	_player_array.push_back('hagalaz')
	_test()
	_check_if_done()

func _on_CairnIsaz_isaz():
	_player_array.push_back('isaz')
	_test()
	_check_if_done()

func _on_CairnSowilo_sowilo():
	_player_array.push_back('sowilo')
	_test()
	_check_if_done()

func _on_CairnBerkanan_berkanan():
	_player_array.push_back('berkanan')
	_test()
	_check_if_done()
	
func _check_if_done():
	if _player_array.size() == _solution_array.size():
		_check_solution()

func _check_solution():
	if _player_array == _solution_array:
		GameState.unlock_exit()
	elif _player_array != _solution_array:
		_player_array.clear()

func _test():
	if _player_array.size() >= 0 :
		print(_player_array, _solution_array)
