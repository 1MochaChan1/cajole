extends CustomScene

@export var lights:Array[CottageLight]

var con = Globals.specs.COTTAGEENTRANCE_LIGHT_FLICKER


func _ready():
	initialize()
	var enemies = get_tree().get_nodes_in_group("Enemies")
	for enemy in enemies:
		if(enemy is Enemy):
			enemy.player = player
	anim_player.play('fade')
	$Timer.wait_time = randf_range(1,6)
	
func flicker_lights():
	var trigger = con in\
		Globals.spec_execs_list
	
	if(trigger):
		var light = lights[randi_range(0,1)]
		light.flicker = true
		await get_tree().create_timer(1).timeout
		light.flicker = false
		light.energy = 1.53
			
		Globals.spec_execs_list.erase(
			Globals.specs.COTTAGEENTRANCE_LIGHT_FLICKER)


func _on_timer_timeout():
	flicker_lights()
