extends KinematicBody2D

var rotv = 1;
var player = true;
var v_x = 400;
var v_y = 200;
var sprite

func _ready():
	set_process(true)
	if (get_name() == 'Sprite1'):
		rotv = -1
		player = false;
	sprite = get_node('sprite')

func _process(delta):
	sprite.rotate(rotv*delta)
	if (player):
		if (Input.is_action_pressed("ui_left")):
			move(Vector2(-delta*v_x, 0))
		if (Input.is_action_pressed("ui_right")):
			move(Vector2(delta*v_x, 0))
		move(Vector2(0, delta*v_y))
		var pos = get_pos()
		if (is_colliding()):
			player = false;
			get_parent().new_gear()
