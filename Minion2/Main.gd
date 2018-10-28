extends Node

var lifes_player = 3
var offset_vidas = 30
var listLifes = []
export (PackedScene) var spr_vidas

func _ready():
	create_lifes()

func create_lifes():
	for i in lifes_player:
		var newLife = spr_vidas.instance()
		get_tree().get_nodes_in_group("gui")[0].add_child(newLife)
		newLife.global_position.x += offset_vidas * i
		listLifes.append(newLife)
		
func delete_life():
	var newLife = spr_vidas.instance()
	print("en delete_life")
	lifes_player -= 1

	var child = get_tree().get_nodes_in_group("gui")[0].get_child(0)
	#	if child.is_in_group("coin") && !delete:
	#		child.queue_free()
	#		delete = true

	#print("COUNT")
	#print(count)
	#var child = get_tree().get_nodes_in_group("gui")[0].get_child(count)
	#get_tree().get_nodes_in_group("gui")[0].remove_child(child)
	listLifes.pop_back()
	
func add_life():
	lifes_player += 1
	var newLife = spr_vidas.instance()
	get_tree().get_nodes_in_group("gui")[0].add_child(newLife)
	newLife.global_position.x += offset_vidas * (lifes_player-1)
	listLifes.push_back(newLife)