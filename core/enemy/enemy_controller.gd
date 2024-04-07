class_name Enemy extends CharacterBody2D

signal attacked

const GRAVITY = 10

@export var walk_speed:float
@export var max_speed:float
@export var lerp_speed = 0.25 
@export var ray_cast:RayCast2D

var player_detected:bool = false
var player:Player
var look_dir
var _speed_multiplier:float = 50

func _ready():
	pass


func _physics_process(delta):
	velocity.y += GRAVITY
	if(player):
		detect_player()
	move_and_slide()
	

func flip_char(dir):
	scale.x = scale.y * dir

func detect_player():
	look_dir = (player.position-global_position).normalized().x
	flip_char(look_dir)
	if (ray_cast.is_colliding()):
		var body = ray_cast.get_collider()
		if (body is Player):
			move_towards_player()

func move_towards_player():
	var x = look_dir * walk_speed * _speed_multiplier
	velocity.x = lerp(velocity.x, x, lerp_speed)
	velocity.x = clamp(velocity.x, -max_speed, max_speed)
	
func attack():
	pass
