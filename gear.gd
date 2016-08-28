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
var driver_number = -1;
var parent_gears = [];

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
	var new_parent_gears = []
	for collider in colliders:
		if (collider.has_method('break_gear')):
			if collider.broken_gear:
				continue
			if collider in parent_gears:
				if collider.driver_number >= 0:
					new_parent_gears.append(collider)
			elif collider.driver_number < driver_number:
				collider.parent_gears.append(self)
				if collider.driver_number >= 0 and driver_number%2 != collider.driver_number%2:
					collider.break_gear()
				collider.driver_number = driver_number + 1
	parent_gears = new_parent_gears
	if !starting_gear and parent_gears.size() == 0:
		rotv = 0
		driver_number = -1
	else:
		print(driver_number)
		rotv = -1 + (driver_number%2)*2

func break_gear():
	broken_gear = true
	rotv = 0
	sprite.hide()
	get_node('broken').show()
