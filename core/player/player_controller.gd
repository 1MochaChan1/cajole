class_name Player extends CharacterBody2D

signal opened_door(packed_scene:PackedScene, scene_data:SceneData)

const GRAVITY = 10

@export var walk_speed:float
@export var max_walk_speed:float
@export var sprint_speed:float
@export var max_sprint_speed:float
@export var animation_player:AnimationPlayer
@export var camera:Camera2D
@export var actionable_detector:Area2D
@export var label:Label
@export var _actionable_diag_caller:Actionable

var jump_strength = 5
var lerp_speed = 0.25 
var speed
var max_speed
var curr_scene_data:SceneData

var _can_interact:bool = false
var _changing_scene:bool = false
var _sprinting:bool = false # using for animation
var _speed_multiplier:float = 50
var _next_scene:PackedScene
var _curr_scene:CustomScene
var x_axis:float

func _ready():
	speed = walk_speed
	max_speed = max_walk_speed
	_curr_scene = self.get_parent()
	curr_scene_data = _curr_scene.scene_data
	set_camera_bounds()


func _physics_process(_delta):
	handle_label()
	velocity.x = lerp(velocity.x, x_axis, lerp_speed)
	velocity.x = clamp(velocity.x, -max_speed, max_speed)
	handle_animation()
	velocity.y += GRAVITY
	if(velocity.x < 0):
		flip_char(-1)
	elif (velocity.x > 0):
		flip_char(1)
	if(!_changing_scene):
		move_and_slide()


func _unhandled_input(_event:InputEvent):
	x_axis = (
		Input.get_action_strength("right") - Input.get_action_strength("left")
		) * speed * _speed_multiplier
	
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
		
	if(Input.is_action_just_pressed("interact")):
		var interactables: = actionable_detector.get_overlapping_areas()
		if(interactables.size() > 0):
			if(interactables[0] is Door):
				handle_interact(Globals.INTERACTIONS.DOOR, interactables[0])
			if(interactables[0] is DoorKey):
				handle_interact(Globals.INTERACTIONS.KEY, interactables[0])
			if(interactables[0] is Actionable):
				handle_interact(Globals.INTERACTIONS.CHARACTER, interactables[0])


func handle_interact(_interaction:Globals.INTERACTIONS,_body=null):
	match _interaction:
		Globals.INTERACTIONS.DOOR:
			var keys = curr_scene_data.keys_on_player
			if(_body.blocked):
				return
			elif(_body.locked and not(_body.door_number in keys)):
				_actionable_diag_caller.dialogue_start = "door_locked"
				_actionable_diag_caller.action()
				return
			elif(_body.locked and (_body.door_number in keys)):
					pass
			_next_scene = _body.leads_to
			_changing_scene = true
			opened_door.emit(_next_scene, curr_scene_data)
		
		Globals.INTERACTIONS.KEY:
			if(_body.key_number not in curr_scene_data.keys_on_player):
				curr_scene_data.keys_on_player.append(_body.key_number)
				_body.queue_free()
		
		Globals.INTERACTIONS.CHARACTER:
			_body.action()
		
		Globals.INTERACTIONS.CLOSET:
			pass

func handle_animation():
	if(abs(velocity.x) > 1):
		animation_player.play('run')
	else:
		animation_player.play('idle')
	
	if(_sprinting):
		animation_player.speed_scale = 1.5
	else:
		animation_player.speed_scale = 1

func handle_label():
	var actionables: = actionable_detector.get_overlapping_areas()
	if(actionables.size() > 0):
		label.show()
	else:
		label.hide()
	if(velocity.x < 0):
		label.scale.x = label.scale.y*-1
	elif (velocity.x > 0):
		label.scale.x = label.scale.y*1
	
	

func set_camera_bounds():
	camera.limit_top = int(_curr_scene.camera_bounds_tl.global_position.y)
	camera.limit_left = int(_curr_scene.camera_bounds_tl.global_position.x)
	camera.limit_bottom = int(_curr_scene.camer_bounds_br.global_position.y)
	camera.limit_right = int(_curr_scene.camer_bounds_br.global_position.x)


func flip_char(dir):  # I Don't Know How This Works
	scale.x = lerp(scale.x,  scale.y * dir, lerp_speed) # See How It Works in Debug


func toggle_flashlight():
	pass
