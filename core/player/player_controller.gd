extends CharacterBody2D

signal interacted(packed_scene:PackedScene, scene_data:SceneData)

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
var _interactable:Globals.INTERACTIONS
var _speed_multiplier:float = 50
var _next_scene:PackedScene

func _ready():
	speed = walk_speed
	max_speed = max_walk_speed
	curr_scene_data = SceneData.new()

func _physics_process(_delta):
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
	
	if(_can_interact and Input.is_action_just_pressed("interact")):
		print(_interactable)
		var scene = load("res://levels/TestScene2.tscn")
		interacted.emit(_next_scene, curr_scene_data)
	
	move_and_slide()


func flip_char(dir):  # I Don't Know How This Works
	scale.x = lerp(scale.x,  scale.y * dir, lerp_speed) # See How It Works in Debug

func toggle_flashlight():
	if(ray_cast):
		ray_cast.enabled = !ray_cast.enabled 
	

func _on_area_2d_body_entered(body):
	if(body is Door):
		_next_scene = body.leads_to
		_interactable = Globals.INTERACTIONS.DOOR
		_can_interact = true


func _on_area_2d_body_exited(body):
	if(body is Door):
		_interactable = Globals.INTERACTIONS.DOOR
		_can_interact = false
