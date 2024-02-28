class_name CustomScene extends Node2D

@export var spawn_point:Node2D
@export var player:CharacterBody2D
@export var scene_data:SceneData

signal scene_changed(new_scene_data:SceneData)

func spawn_player():
	var player_scene = preload("res://core/player/Player.tscn")
	player = player_scene.instantiate()
	add_child(player)
	player.global_position = spawn_point.global_position
	player.interacted.connect(change_scene)

func change_scene(new_scene:PackedScene, _data:SceneData):
	get_tree().change_scene_to_packed(new_scene)
	
