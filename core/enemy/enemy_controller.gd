extends CharacterBody2D

const GRAVITY = 10

@export var walk_speed:float
@export var max_speed:float
var walk_dir = 1

var player_detected:bool = false
var player_pos:Vector3

func _ready():
	pass


func _physics_process(delta):
	flip_char(player_pos.normalized().x)

func flip_char(dir):
	scale.x = scale.y * dir
