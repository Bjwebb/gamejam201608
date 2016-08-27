extends Node2D

# member variables here, example:
# var a=2
# var b="textvar"

var gear_scene

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	gear_scene = load('res://gear.tscn')
	new_gear()

func new_gear():
	var gear = gear_scene.instance();
	add_child(gear)

