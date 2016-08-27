extends Node2D

# member variables here, example:
# var a=2
# var b="textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	new_gear()

func new_gear():
	var gear = get_node('gear').duplicate()
	gear.player = true;
	add_child(gear)

