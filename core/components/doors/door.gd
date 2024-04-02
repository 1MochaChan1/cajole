class_name Door extends Node

@export var res:DoorRes
var leads_to
func _ready():
	leads_to = load(res.leads_to)
