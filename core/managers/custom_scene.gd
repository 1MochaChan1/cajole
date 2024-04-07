class_name CustomScene extends Node2D

@export var spawn_point:Node2D
@export var player:Player
@export var scene_data:SceneData

signal scene_changed(new_scene_data:SceneData)

func _ready():
	initialize()

func initialize():
	if(not (Globals.scene_data)):
		Globals.scene_data = SceneData.new()
	scene_data = Globals.scene_data
	spawn_player()
	remove_extra_keys()

# spawn player and connect signals
func spawn_player():
	var player_scene = preload("res://core/player/Player.tscn")
	player = player_scene.instantiate()
	add_child(player)
	player.global_position = spawn_point.global_position
	player.opened_door.connect(change_scene)

func change_scene(new_scene:PackedScene, _data:SceneData):
	get_tree().change_scene_to_packed(new_scene)
	Globals.scene_data = _data

func remove_extra_keys():
	var keys_in_scene = get_tree().get_nodes_in_group("Keys")
	for key in keys_in_scene:
		if(key.key_number in scene_data.keys_on_player):
			key.queue_free()
