extends CustomScene

func _ready():
	initialize()
	var enemies = get_tree().get_nodes_in_group("Enemies")
	for enemy in enemies:
		if(enemy is Enemy):
			enemy.player = player
	dim_lights()


func flicker_lights():
	print('lights flickering')
	dim_lights()

func dim_lights():
	if(Globals.specs.BEDROOM1_LOUD_SOUND_N_MUSIC not in Globals.spec_exec):
		print('lights dimmed')

func _on_key_tree_exited():
	if(Globals.specs.BEDROOM1_LOUD_SOUND_N_MUSIC in Globals.spec_exec):
		flicker_lights()
		Globals.spec_exec.remove_at(Globals.specs.BEDROOM1_LOUD_SOUND_N_MUSIC)
