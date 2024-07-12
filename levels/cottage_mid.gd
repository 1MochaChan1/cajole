extends CustomScene

@export_range(0, 999999) var passcode:int
@export var ap_monster_sighting:AnimationPlayer
@export var sighting_trigger_l:CollisionShape2D
@export var sighting_trigger_r:CollisionShape2D
@export var light_to_flicker:CottageLight

var _figure_sighting = Globals.specs.COTTAGEMID_FIGURE_SIGHTING
var _taken_br4_clue = Globals.specs.BEDROOM4_TAKEN_LAST_CLUE


func _ready():
	initialize()
	var enemies = get_tree().get_nodes_in_group("Enemies")
	for enemy in enemies:
		if(enemy is Enemy):
			enemy.player = player
	trigger_figure_sighting()


func trigger_figure_sighting():
	if((_figure_sighting in Globals.spec_execs_list) and 
		(_taken_br4_clue not in Globals.spec_execs_list)):
		light_to_flicker.flicker = true
		ap_monster_sighting.play("blink")
		toggle_colliders(true)

func toggle_colliders(value:bool):
	sighting_trigger_l.set_deferred('disabled', !value)
	sighting_trigger_r.set_deferred('disabled', !value)

func _on_closeup_lock_on_closeup(_interactable_node):
	_interactable_node.show()


func _on_line_edit_text_changed(new_text:String):
	if(len(new_text)<6):
		diag_caller.hide_balloon()
	if(len(new_text)==6):
		if(new_text==str(passcode)):
			var basement_scene = preload("res://levels/End.tscn")
			diag_caller.next_scene_path = basement_scene
			diag_caller.dialogue_start='right_passcode'
		else:
			diag_caller.dialogue_start='wrong_passcode'
		diag_caller.action()


func play_vanish_anim():
	if(_figure_sighting in Globals.spec_execs_list):
		ap_monster_sighting.play("vanish")
		Globals.spec_execs_list.erase(_figure_sighting)
		


func _on_closeup_lock_on_closeup_exit(_interactable_node):
	_interactable_node.hide()


func _on_sighting_trigger_l_body_entered(body):
	if(_figure_sighting in Globals.spec_execs_list):
		play_vanish_anim()
		toggle_colliders(false)


func _on_sighting_trigger_r_body_entered(body):
	if(_figure_sighting in Globals.spec_execs_list):
		play_vanish_anim()
		toggle_colliders(false)
		
