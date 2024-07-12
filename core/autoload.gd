extends Node

var ambience_player:AudioStreamPlayer2D
var ambience_mp3:AudioStreamMP3
var _curr_ambience_mp3:AudioStreamMP3

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
	ambience_player = AudioStreamPlayer2D.new()
	ambience_player.volume_db = -15.0
	add_child(ambience_player)
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



func play_ambience():
	if(ambience_mp3):
		if(not(_curr_ambience_mp3 == ambience_mp3)):
			ambience_player.stop()
			_curr_ambience_mp3 = ambience_mp3
			ambience_player.stream = _curr_ambience_mp3
			ambience_player.play()
		elif (not ambience_player.playing):
			ambience_player.play()
