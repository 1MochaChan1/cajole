extends CustomScene

@export_range(0, 999999) var passcode:int

func _ready():
	initialize()
	var enemies = get_tree().get_nodes_in_group("Enemies")
	for enemy in enemies:
		if(enemy is Enemy):
			enemy.player = player
	trigger_figure_sighting()

func trigger_figure_sighting():
	var trigger = Globals.specs.COTTAGEMID_FIGURE_SIGHTING
	var trigger2 = Globals.specs.BEDROOM4_TAKEN_LAST_CLUE
	
	if((trigger in Globals.spec_execs_list) and (trigger2 not in Globals.spec_execs_list)):
		print("Figure sighting")
		Globals.spec_execs_list.erase(trigger) 
		


func _on_closeup_lock_on_closeup(_interactable_node):
	_interactable_node.show()


func _on_line_edit_text_changed(new_text:String):
	if(len(new_text)<6):
		diag_caller.hide_balloon()
	if(len(new_text)==6):
		if(new_text==str(passcode)):
			var basement_scene = preload("res://levels/TestScene2.tscn")
			diag_caller.next_scene_path = basement_scene
			diag_caller.dialogue_start='right_passcode'
		else:
			diag_caller.dialogue_start='wrong_passcode'
		diag_caller.action()


func _on_closeup_lock_on_closeup_exit(_interactable_node):
	_interactable_node.hide()
