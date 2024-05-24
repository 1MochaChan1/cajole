class_name Closeup extends Area2D

@export var camera:Camera2D
@export var interact_obj:Node

signal on_closeup(_interactable_node)
signal on_closeup_exit(_interactable_node)

func switch_camera():
	camera.enabled=true
	camera.make_current()
	on_closeup.emit(interact_obj)

func switch_back_camera():
	camera.enabled = false
	camera.is_current()
	on_closeup_exit.emit(interact_obj)
