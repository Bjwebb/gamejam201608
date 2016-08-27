extends Node2D

# member variables here, example:
# var a=2
# var b="textvar"

var gear_scene

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	get_node('starting_gear').rotv = 1
	get_node('starting_gear').starting_gear = true;
	#get_node('ending_gear').ending_gear = true;
	gear_scene = load('res://gear.tscn')
	new_gear()

func new_gear():
	var gear = gear_scene.instance();
	gear.player = true
	add_child(gear)

