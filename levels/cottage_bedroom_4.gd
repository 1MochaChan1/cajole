extends CustomScene

func _ready():
	initialize()
	var enemies = get_tree().get_nodes_in_group("Enemies")
	for enemy in enemies:
		if(enemy is Enemy):
			enemy.player = player


func looked_at_clue():
	var trigger = Globals.specs.BEDROOM4_TAKEN_LAST_CLUE 
	if(trigger in Globals.spec_execs_list):
		Globals.spec_execs_list.erase(trigger)


func _on_closeup_on_closeup(_interactable_node):
	_interactable_node.show()
	looked_at_clue()


func _on_closeup_on_closeup_exit(_interactable_node):
	_interactable_node.hide()
