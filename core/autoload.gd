extends Node

enum INTERACTIONS {DOOR, CHARACTER, CLOSET}
var scene_data:SceneData

func change_scene(new_scene:PackedScene, _data:SceneData=null):
	get_tree().change_scene_to_packed(new_scene)
	if(_data):
		self.scene_data = _data
