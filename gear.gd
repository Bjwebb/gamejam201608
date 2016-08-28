extends RigidBody2D

var rotv = 0;
var player = false;
var v_x = 400;
var v_y = 200;
var starting_gear = false;
var ending_gear = false;
var broken_gear = false;
var sprite;
var driver;

func _ready():
	set_process(true)
	sprite = get_node('sprite')

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
	if (broken_gear):
		return

func tree_process():
	if broken_gear:
		return
	var colliders = get_colliding_bodies()
	for collider in colliders:
		if (collider.has_method('tree_process')):
			if collider.broken_gear:
				continue
			if collider.rotv == 0:
				collider.rotv = -rotv
				collider.tree_process()
			elif rotv != -collider.rotv:
				collider.break_gear()

func break_gear():
	broken_gear = true
	rotv = 0
	sprite.hide()
	get_node('broken').show()

