class_name CottageLight extends PointLight2D

@export var flicker:bool = false
@export var lowest_light_strength:float = 0.05
@export var highest_light_strength:float = 1.5
@export_range(0,1) var lerp_weight:float=0.1
@export var step:float = 0.5
@onready var audio_player = $AudioStreamPlayer2D
@onready var audio_timer = $AudioTimer


func _physics_process(delta):
	var length = audio_player.stream.get_length()
	if(flicker):
		_flicker_lights()
		if(audio_timer.is_stopped()):
			audio_timer.start(length)
			audio_player.play()
	else:
		if(audio_player.playing):
			audio_player.stop()

func _flicker_lights():
	var light_energy_start = randf_range(lowest_light_strength,
	lowest_light_strength+step)
	
	var light_energy_end = randf_range(highest_light_strength - step, highest_light_strength)
	energy = lerp(light_energy_start, light_energy_end, lerp_weight)
