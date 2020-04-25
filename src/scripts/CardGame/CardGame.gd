extends Node2D

var allCards = Array()
export(Array, Texture) var _card_textures = Array()
export(float) var _delayed_flip_time = 1

var _previously_flipped_card : Card
var _cards = Array()
var _rng := RandomNumberGenerator.new()

var poof = preload('res://vfx/Poof.tscn')

# Called when the node enters the scene tree for the first time.
func _ready():
	print(get_tree().get_root())
	_rng.randomize()
	var temp_card_array = allCards.duplicate()
	var texture_max_index = _card_textures.size() - 1
	var rand_texture_index = _rng.randi_range(0, texture_max_index)
	var i
	while temp_card_array.size() > 0:
		rand_texture_index += 1
		if rand_texture_index > texture_max_index:
			rand_texture_index = 0
		i = _rng.randi_range(0, temp_card_array.size() - 1)
		temp_card_array[i].assign_texture(_card_textures[rand_texture_index])
		temp_card_array.remove(i)
		i = _rng.randi_range(0, temp_card_array.size() - 1)
		temp_card_array[i].assign_texture(_card_textures[rand_texture_index])
		temp_card_array.remove(i)

func on_card_flip(card : Card):
	if card != _previously_flipped_card:
		if _previously_flipped_card != null:
			if card.sprite.texture == _previously_flipped_card.sprite.texture:
				yield(get_tree().create_timer(0.4), 'timeout')
				allCards.erase(_previously_flipped_card)
				despawn_effect(_previously_flipped_card)
				_previously_flipped_card.queue_free()
				_previously_flipped_card = null
				allCards.erase(card)
				despawn_effect(card)
				card.queue_free()
				if allCards.size() == 0:
					get_node('/root/GameState').unlock_exit()
					pass
			else:
				_previously_flipped_card.start_delayed_flip(_delayed_flip_time)
				_previously_flipped_card = null
				card.start_delayed_flip(_delayed_flip_time)
		else:
			_previously_flipped_card = card

func despawn_effect(card):
	var inst = poof.instance()
	inst.position = card.position
	owner.find_node('YSort').add_child(inst)
	yield(get_tree().create_timer(1), 'timeout')
	inst.queue_free()
