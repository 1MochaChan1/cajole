extends CustomScene

func _ready():
	initialize()
	var enemies = get_tree().get_nodes_in_group("Enemies")
	for enemy in enemies:
		if(enemy is Enemy):
			enemy.player = player


func _on_closeup_on_closeup(_interactable_node):
	_interactable_node.show()


func _on_closeup_on_closeup_exit(_interactable_node):
		_interactable_node.hide()
