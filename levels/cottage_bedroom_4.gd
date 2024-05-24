extends CustomScene

func _ready():
	initialize()
	var enemies = get_tree().get_nodes_in_group("Enemies")
	for enemy in enemies:
		if(enemy is Enemy):
			enemy.player = player

func looked_at_clue():
	var trigger = Globals.specs.BEDROOM4_TAKEN_LAST_CLUE 
	if(trigger in Globals.spec_exec):
		Globals.spec_exec.remove_at(trigger)
