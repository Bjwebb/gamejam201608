extends Sprite

var rotv = 1;
var player = true;
var v_x = 400;
var v_y = 100;

func _ready():
	set_process(true)
	if (get_name() == 'Sprite1'):
		rotv = -1
		player = false;

func _process(delta):
	rotate(rotv*delta)
	if (Input.is_action_pressed("ui_left")):
		translate(Vector2(-delta*v_x, 0))
	if (Input.is_action_pressed("ui_right")):
		translate(Vector2(delta*v_x, 0))
	translate(Vector2(0, delta*v_y))
