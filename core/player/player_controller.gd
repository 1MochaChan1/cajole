extends CharacterBody2D

signal interacted(interaction_type:Globals.INTERACTIONS, scene_data:SceneData)

const GRAVITY = 10

@export var walk_speed:float
@export var max_walk_speed:float
@export var sprint_speed:float
@export var max_sprint_speed:float
@export var ray_cast:RayCast2D

var walk_dir = 1
var jump_strength = 5
var lerp_speed = 0.25 
var speed
var max_speed
var curr_scene_data

var _can_interact:bool = false
var _interactable
var _speed_multiplier:float = 50

func _ready():
	speed = walk_speed
	max_speed = max_walk_speed

func _physics_process(delta):
	velocity.y += GRAVITY
	if(velocity.x < 0):
		flip_char(-1)
	elif (velocity.x > 0):
		flip_char(1)
	handle_input()

func handle_input():
	var x = 	(
		Input.get_action_strength("right") - Input.get_action_strength("left")
		) * speed * _speed_multiplier
	velocity.x = lerp(velocity.x, x, lerp_speed)
	velocity.x = clamp(velocity.x, -max_speed, max_speed)
	
	if(Input.is_action_just_pressed("sprint")):
		speed = sprint_speed
		max_speed = max_sprint_speed
	
	if(Input.is_action_just_released("sprint")):
		speed = walk_speed
		max_speed = max_walk_speed
	
	if(Input.is_action_just_pressed("toggle flashlight")):
		toggle_flashlight()
	
	if(Input.is_action_just_pressed("interact")):
		interacted.emit(Globals.INTERACTIONS.DOOR, )
	
	move_and_slide()


func flip_char(dir):  # I Don't Know How This Works
	scale.x = lerp(scale.x,  scale.y * dir, lerp_speed) # See How It Works in Debug

func toggle_flashlight():
	if(ray_cast):
		ray_cast.enabled = !ray_cast.enabled 


func _on_area_2d_area_entered(area):
	if(area.name=="Door"):
		print("Door")


func _on_area_2d_area_exited(area):
	if(area.name=="Door"):
		print("Door")
