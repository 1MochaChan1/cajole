extends CustomScene

func _ready():
	initialize()
	var enemies = get_tree().get_nodes_in_group("Enemies")
	for enemy in enemies:
		if(enemy is Enemy):
			enemy.player = player


func loud_music():
	if(Globals.specs.BEDROOM1_LOUD_SOUND_N_MUSIC in Globals.spec_execs_list):
		print('play loud music')
		Globals.spec_execs_list.erase(
			Globals.specs.BEDROOM1_LOUD_SOUND_N_MUSIC)


func _on_key_tree_exited():
	loud_music()
