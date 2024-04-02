extends Node

var curr_scene:CustomScene 

func _ready():
	var children = get_children()
	if(len(children) > 0):
		if(children[0] is CustomScene):
			curr_scene = children[0]
			if(curr_scene.scene_data == null):
				curr_scene.scene_data = SceneData.new()
			#curr_scene.scene_changed.connect(update_data)


func update_data(new_scene_data:SceneData):
	curr_scene.scene_data = new_scene_data
