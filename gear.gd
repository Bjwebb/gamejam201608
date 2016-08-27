extends RigidBody2D

var rotv = 0;
var player = false;
var v_x = 400;
var v_y = 200;
var sprite

func _ready():
	set_process(true)
	if (get_name() == 'Sprite1'):
		rotv = -1
		player = false;
	sprite = get_node('sprite')

func get_rotv():
	return rotv

func _process(delta):
	sprite.rotate(rotv*delta)
	var colliders = get_colliding_bodies()
	if (player):
		if (Input.is_action_pressed("ui_left")):
			translate(Vector2(-delta*v_x, 0))
		if (Input.is_action_pressed("ui_right")):
			translate(Vector2(delta*v_x, 0))
		if (colliders.size() > 0):
			player = false;
			get_parent().new_gear()
	for collider in colliders:
		if (collider.has_method('get_rotv')):
			var other_rotv = collider.get_rotv()
			if (other_rotv > 0):
				rotv = -other_rotv
