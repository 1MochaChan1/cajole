extends Node

var curr_scene_data:SceneData 

func _ready():
	var children = get_children()
	if(len(children) > 0):
		if(children[0] is CustomScene):
			children[0].scene_changed.connect(update_data)


func update_data(new_scene_data:SceneData):
	curr_scene_data = new_scene_data
