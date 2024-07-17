extends CustomScene
@onready var car_crash = $CarCrash
@onready var crash_sound_end = $CrashSoundEnd

func _ready():
	initialize()
	var enemies = get_tree().get_nodes_in_group("Enemies")
	for enemy in enemies:
		if(enemy is Enemy):
			enemy.player = player


func _on_start_pressed():
	car_crash.play(10.0)
	crash_sound_end.start(3)


func _on_crash_sound_end_timeout():
	var village_entrance_scene = preload(
		"res://levels/VillageEntrance.tscn")
	change_scene_with_transition(village_entrance_scene)
