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



func _on_closeup_lock_on_closeup(_interactable_node):
	_interactable_node.show()


func _on_line_edit_text_changed(new_text):
	# TODO: Add a go back fucntion.
	if(len(new_text)<6):
		diag_caller.hide_balloon()
	if(len(new_text)==6):
		if(new_text==str(123456)):
			diag_caller.dialogue_start='right_passcode'
			# unlock door #
		else:
			diag_caller.dialogue_start='wrong_passcode'
		diag_caller.action()


func _on_closeup_lock_on_closeup_exit(_interactable_node):
	_interactable_node.hide()
