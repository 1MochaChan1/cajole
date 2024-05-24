extends CustomScene

@export var dialogue_caller:Actionable

var passcode:int = 191620

func _ready():
	initialize()
	var enemies = get_tree().get_nodes_in_group("Enemies")
	for enemy in enemies:
		if(enemy is Enemy):
			enemy.player = player

# Show Password Tab
func _on_closeup_lock_on_closeup(_interactable_node:Node):
	_interactable_node.show()


func _on_line_edit_text_changed(new_text):
	if(len(new_text)==6):
		if(new_text==str(passcode)):
			dialogue_caller.dialogue_start='right_passcode'
			# unlock door #
		else:
			dialogue_caller.dialogue_start='wrong_passcode'
		dialogue_caller.action()


func _on_closeup_lock_on_closeup_exit(_interactable_node):
	_interactable_node.hide()
