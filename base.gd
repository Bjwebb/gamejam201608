extends Node2D

# member variables here, example:
# var a=2
# var b="textvar"

var gear_scene
var starting_gears

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	var starting_gear = get_node('starting_gear')
	starting_gear.rotv = 1
	starting_gear.starting_gear = true;
	starting_gear.driver_number = 0;
	get_node('ending_gear').ending_gear = true;
	gear_scene = load('res://gear.tscn')
	new_gear()

func new_gear():
	var gear = gear_scene.instance();
	gear.player = true
	add_child(gear)
