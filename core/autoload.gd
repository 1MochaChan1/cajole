extends Node


enum INTERACTIONS {DOOR, CHARACTER, CLOSEUP, KEY}
var scene_data:SceneData
var spec_exec:Array[int] = []
enum specs {
		BEDROOM1_LOUD_SOUND_N_MUSIC,
		BEDROOM4_TAKEN_LAST_CLUE,
		COTTAGEMID_FIGURE_SIGHTING,
	}

func _init():
	for x in range(len(specs)):
		spec_exec.append(x)

# Take signals and exec funcs here.
func change_scene(new_scene:PackedScene, _data:SceneData=null):
	get_tree().change_scene_to_packed(new_scene)
	if(_data):
		self.scene_data = _data

