extends RigidBody2D

var rotv = 0;
var player = false;
var v_x = 400;
var v_y = 200;
var starting_gear = false;
var ending_gear = false;
var broken_gear = false;
var sprite;

func _ready():
	set_process(true)
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
	if !starting_gear:
		rotv = 0
	for collider in colliders:
		if (collider.has_method('get_rotv')):
			var other_rotv = collider.get_rotv()
			if (other_rotv != 0):
				if (rotv == 0 and !broken_gear):
					rotv = -other_rotv
				elif (rotv == other_rotv):
					broken_gear = true
					rotv = 0
