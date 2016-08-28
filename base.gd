extends Node2D

# member variables here, example:
# var a=2
# var b="textvar"

var gear_scene
var starting_gear
var ending_gear

var gears = []
var score = 0
var score_f = 0.0

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	starting_gear = get_node('starting_gear')
	starting_gear.starting_gear = true;
	ending_gear = get_node('ending_gear')
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
	if ending_gear.rotv != 0:
		score_f += delta * 10
		score = int(score_f)
		get_node('score').set_bbcode(str(score))