extends CustomScene

func _ready():
	initialize()
	var enemies = get_tree().get_nodes_in_group("Enemies")
	for enemy in enemies:
		if(enemy is Enemy):
			enemy.player = player


func _on_start_pressed():
	var village_entrance_scene = preload(
		"res://levels/VillageEntrance.tscn")
	change_scene_with_transition(village_entrance_scene)
