class_name Closeup extends Area2D

@export var camera:Camera2D

func switch_camera():
	camera.enabled=true
	camera.make_current()

func switch_back_camera():
	camera.enabled = false
	camera.is_current()
