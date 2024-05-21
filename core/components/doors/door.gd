class_name Door extends Area2D

@export var leads_to_scene:String
@export var locked:bool
@export var door_number:int
@export var blocked:bool
@export var spawn_loc:Marker2D
var leads_to

func _ready():
	leads_to = load(leads_to_scene)
