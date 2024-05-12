extends Area2D

const Balloon = preload("res://core/dialogues/balloon.tscn")

@export var dialogue_resource:DialogueResource
@export var dialogue_start:String
# Use this variable if you want to navigate to a scene after the dialog ends.
# Haven't added scene_data as param yet.
@export var next_scene_path:PackedScene 

func action() -> void:
	var balloon:Node = Balloon.instantiate()
	get_tree().current_scene.add_child(balloon)
	balloon.start(dialogue_resource, dialogue_start)
	if(next_scene_path):
		DialogueManager.dialogue_ended.connect(change_scene_from_globals)

func change_scene_from_globals(_someparm):
	Globals.change_scene(next_scene_path)
