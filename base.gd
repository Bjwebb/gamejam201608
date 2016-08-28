extends Node2D

# member variables here, example:
# var a=2
# var b="textvar"

var gear_scene
var starting_gear

var gears = []

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	starting_gear = get_node('starting_gear')
	starting_gear.starting_gear = true;
	var ending_gear = get_node('ending_gear')
	ending_gear.ending_gear = true;
	gear_scene = load('res://gear.tscn')
	gears.append(starting_gear)
	gears.append(ending_gear)
	new_gear()
	set_process(true)

func new_gear():
	var gear = gear_scene.instance();
	gear.player = true
	add_child(gear)
	gears.append(gear)

func _process(delta):
	for gear in gears:
		gear.rotv = 0
	starting_gear.rotv = 1
	starting_gear.tree_process()