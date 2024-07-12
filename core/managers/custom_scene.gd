class_name CustomScene extends Node2D

@export var spawn_point:Node2D
@export var player:Player
@export var scene_data:SceneData

@export var camera_bounds_tl:Marker2D
@export var camer_bounds_br:Marker2D
@export var diag_caller:Actionable
@export var anim_player:AnimationPlayer
@export var can_spawn_player:bool=true

## SOUNDS ##
@export var walking_sound:AudioStreamPlayer2D
@export var ambience_mp3:AudioStreamMP3

signal scene_changed(new_scene_data:SceneData)

func _ready():
	initialize()

func initialize():
	
	if(not (Globals.scene_data)):
		Globals.scene_data = SceneData.new()
	scene_data = Globals.scene_data
	if(ambience_mp3):
		Globals.ambience_mp3 = ambience_mp3
		Globals.play_ambience()
	if (can_spawn_player):
		spawn_player()
	remove_extra_keys()

# spawn player and connect signals
func spawn_player():
	var player_scene = preload("res://core/player/Player.tscn")
	var spawn_loc = spawn_point.global_position
	if(spawn_loc):
		player = player_scene.instantiate()
		add_child(player)
	
	if(Globals.scene_data.spawn_door_no!=null):
		var door_no = Globals.scene_data.spawn_door_no
		var doors_in_scene = get_tree().get_nodes_in_group("Doors")
		for door:Door in doors_in_scene:
			if(door.door_number==door_no):
				spawn_loc = door.spawn_loc.global_position
				break
		player.global_position = spawn_loc
	player.opened_door.connect(change_scene)

# Changes scenes along with Scenedat passed
func change_scene(new_scene:PackedScene, _data:SceneData=null):
	get_tree().change_scene_to_packed(new_scene)
	Globals.scene_data = _data

func change_scene_with_transition(
	new_scene:PackedScene, 
	_data:SceneData=null):
	anim_player.play('dissolve')
	await anim_player.animation_finished
	get_tree().change_scene_to_packed(new_scene)
	Globals.scene_data = _data
	anim_player.play_backwards()


func remove_extra_keys():
	var keys_in_scene = get_tree().get_nodes_in_group("Keys")
	for key in keys_in_scene:
		if(key.key_number in scene_data.keys_on_player):
			key.queue_free()
