extends Door

@export var scene_path:String

# Called when the node enters the scene tree for the first time.
func _ready():
	var _scene:PackedScene = load(scene_path)
	leads_to = _scene


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
