class_name DoorKey extends Area2D
@export var key_number:int
var _time=0
func _physics_process(delta):
	_time += delta * 5
	global_position.y = lerpf(
		global_position.y, global_position.y+sin(_time), 0.05)
