extends Node2D


var _solution_array = ['isaz', 'sowilo', 'mannaz', 'hagalaz', 'berkanan']

var _player_array = []

func _on_CairnMannaz_mannaz():
	_player_array.push_back('mannaz')
	_check_solution()

func _on_CairnHagalaz_hagalaz():
	_player_array.push_back('hagalaz')
	_check_solution()

func _on_CairnIsaz_isaz():
	_player_array.push_back('isaz')
	_check_solution()

func _on_CairnSowilo_sowilo():
	_player_array.push_back('sowilo')
	_check_solution()

func _on_CairnBerkanan_berkanan():
	_player_array.push_back('berkanan')
	_check_solution()
	
func _check_solution():
	if _player_array == _solution_array:
		GameState.unlock_exit()
		return
	
	for i in range(0, _player_array.size()):
		if _player_array[i] != _solution_array[i]:
			_player_array.clear()
			break
