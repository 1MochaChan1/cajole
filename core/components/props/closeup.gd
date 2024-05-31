class_name Closeup extends Area2D

@export var camera:Camera2D
@export var interact_obj:Node

'''
Signal emitted when somebody interacts with the closeup object
'''
signal on_closeup(_interactable_node)

'''
Signal emitted when someone switches back from the camers (exiting the closeup)
'''
signal on_closeup_exit(_interactable_node)

func switch_camera():
	camera.enabled=true
	camera.make_current()
	on_closeup.emit(interact_obj)

func switch_back_camera():
	camera.enabled = false
	camera.is_current()
	on_closeup_exit.emit(interact_obj)
