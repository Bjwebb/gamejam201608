extends Sprite

var rotv = 1;
var player = true;

func _ready():
	set_process(true)
	if (get_name() == 'Sprite1'):
		rotv = -1
		player = false;

func _process(delta):
	rotate(rotv*delta)
	Input.is_action_pressed("ui_left")

