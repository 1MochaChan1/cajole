extends CustomScene

func _ready():
	initialize()
	var enemies = get_tree().get_nodes_in_group("Enemies")
	for enemy in enemies:
		if(enemy is Enemy):
			enemy.player = player

func trigger_figure_sighting():
	var trigger = Globals.specs.COTTAGEMID_FIGURE_SIGHTING
	var trigger2 = Globals.specs.BEDROOM4_TAKEN_LAST_CLUE
	
	if((trigger in Globals.spec_exec) and not (trigger2 in Globals.spec_exec)):
		Globals.spec_exec.remove_at(trigger) 
		pass
