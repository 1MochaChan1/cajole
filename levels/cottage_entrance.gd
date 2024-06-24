extends CustomScene


func _ready():
	initialize()
	var enemies = get_tree().get_nodes_in_group("Enemies")
	for enemy in enemies:
		if(enemy is Enemy):
			enemy.player = player

func flicker_lights():
	var con = Globals.specs.COTTAGEENTRANCE_LIGHT_FLICKER
	var trigger = con in\
		Globals.spec_execs_list
	
	if(trigger):
		print("start light flickering")
		Globals.spec_execs_list.erase(
			Globals.specs.COTTAGEENTRANCE_LIGHT_FLICKER)


func _on_timer_timeout():
	flicker_lights()
