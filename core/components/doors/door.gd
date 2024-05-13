class_name Door extends Area2D

@export var res:DoorRes
var leads_to
func _ready():
	leads_to = load(res.leads_to)
