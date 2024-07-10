extends Node


enum INTERACTIONS {DOOR, CHARACTER, CLOSEUP, KEY}
var scene_data:SceneData
# These are special executions, 
var spec_execs_list:Array[int] = []

# These are sepcials that a scene can execute if available in the
# `spec_execs_list` list
enum specs {
	COTTAGEENTRANCE_LIGHT_FLICKER,
	BEDROOM1_LOUD_SOUND_N_MUSIC,
	BEDROOM4_TAKEN_LAST_CLUE,
	COTTAGEMID_FIGURE_SIGHTING,
	}

# Add all the special execs at the start.
func _init():
	for x in range(len(specs)):
		spec_execs_list.append(x)

# Take signals and exec funcs here.
func change_scene(new_scene:PackedScene, _data:SceneData=null):
	get_tree().change_scene_to_packed(new_scene)
	if(_data):
		self.scene_data = _data

func reset():
	spec_execs_list = []
	scene_data = null
