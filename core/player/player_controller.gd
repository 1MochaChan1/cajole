class_name Player extends CharacterBody2D

signal opened_door(packed_scene:PackedScene, scene_data:SceneData)

const GRAVITY = 10

@export var walk_speed:float
@export var max_walk_speed:float
@export var sprint_speed:float
@export var max_sprint_speed:float
@export var ray_cast:RayCast2D
@export var animation_player:AnimationPlayer

var walk_dir = 1
var jump_strength = 5
var lerp_speed = 0.25 
var speed
var max_speed
var curr_scene_data:SceneData

var _can_interact:bool = false
var _changing_scene:bool = false
var _sprinting:bool = false # using for animation
var _interaction:Globals.INTERACTIONS
var _speed_multiplier:float = 50
var _next_scene:PackedScene

func _ready():
	speed = walk_speed
	max_speed = max_walk_speed
	curr_scene_data = self.get_parent().scene_data

	
	
func _physics_process(_delta):
	handle_animation()
	velocity.y += GRAVITY
	if(velocity.x < 0):
		flip_char(-1)
	elif (velocity.x > 0):
		flip_char(1)
	handle_input()

func handle_input():
	var x = (
		Input.get_action_strength("right") - Input.get_action_strength("left")
		) * speed * _speed_multiplier
	velocity.x = lerp(velocity.x, x, lerp_speed)
	velocity.x = clamp(velocity.x, -max_speed, max_speed)
	
	if(Input.is_action_just_pressed("sprint")):
		_sprinting = true
		speed = sprint_speed
		max_speed = max_sprint_speed
	
	if(Input.is_action_just_released("sprint")):
		_sprinting = false
		speed = walk_speed
		max_speed = max_walk_speed
	
	if(Input.is_action_just_pressed("toggle flashlight")):
		toggle_flashlight()
	
	if(_can_interact and Input.is_action_just_pressed("interact")):
		if(_interaction != null):
			handle_interact(_interaction)
	
	if(!_changing_scene):
		move_and_slide()

func handle_animation():
	if(abs(velocity.x) > 1):
		animation_player.play('run')
	else:
		animation_player.play('idle')
	
	if(_sprinting):
		animation_player.speed_scale = 1.5
	else:
		animation_player.speed_scale = 1

func handle_interact(interaction:Globals.INTERACTIONS):
	match interaction:
		Globals.INTERACTIONS.DOOR:
			_changing_scene = true
			opened_door.emit(_next_scene, curr_scene_data)
		
		Globals.INTERACTIONS.KEYS:
			pass
		
		Globals.INTERACTIONS.CLOSET:
			pass

func flip_char(dir):  # I Don't Know How This Works
	scale.x = lerp(scale.x,  scale.y * dir, lerp_speed) # See How It Works in Debug

func toggle_flashlight():
	if(ray_cast):
		ray_cast.enabled = !ray_cast.enabled 

func _on_area_2d_body_entered(body):
	if(body is Door):
		var keys = curr_scene_data.keys_on_player
		if(body.res.locked and not(body.res.door_number in keys)):
			return
		elif (body.res.locked and body.res.door_number in keys):
			body.res.locked = false
			
		_next_scene = body.leads_to
		_interaction = Globals.INTERACTIONS.DOOR
		_can_interact = true


func _on_area_2d_body_exited(body):
	if(body is Door):
		_interaction = Globals.INTERACTIONS.DOOR
		_can_interact = false


func _on_area_2d_area_shape_entered(
	_area_rid, area, area_shape_index, _local_shape_index):
	var node = area.shape_owner_get_owner(area_shape_index).get_node("../..")
	if(node is Key):
		if(node.key_number not in curr_scene_data.keys_on_player):
			curr_scene_data.keys_on_player.append(node.key_number)
			node.queue_free()
