extends CustomScene


func _ready():
	pass
	#anim_player.play('zoom')
	#await anim_player.animation_finished

func _physics_process(delta):
	if(Input.is_action_pressed("ui_accept")):
		var menu = preload("res://levels/Menu.tscn")
		change_scene(menu)
