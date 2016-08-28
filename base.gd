extends Node2D

# member variables here, example:
# var a=2
# var b="textvar"

var gear_scene
var starting_gear
var ending_gear
var player_gear
var time_done = 0
var level

var gears = []

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	level = get_node('/root/global').level
	get_node('score').set_bbcode(str(level))
	starting_gear = get_node('starting_gear')
	starting_gear.starting_gear = true;
	ending_gear = get_node('ending_gear')
	ending_gear.ending_gear = true;
	gear_scene = load('res://gear.tscn')
	gears.append(starting_gear)
	gears.append(ending_gear)
	new_gear()
	set_process(true)
	set_process_input(true)

func new_gear():
	player_gear = gear_scene.instance();
	player_gear.player = true
	add_child(player_gear)
	if rand_range(0,3) < 1:
		player_gear.break_gear()
	gears.append(player_gear)

func _input(event):
	if event.is_action_pressed('ui_select'):
		get_tree().change_scene('res://base.tscn')
	elif event.is_action_pressed('ui_page_up'):
		get_node('/root/global').level += 1
		get_tree().change_scene('res://base.tscn')
	elif event.is_action_pressed('ui_page_down'):
		get_node('/root/global').level -= 1
		get_tree().change_scene('res://base.tscn')

func _process(delta):
	for gear in gears:
		gear.rotv = 0
	starting_gear.rotv = 1
	starting_gear.tree_process()
	
	if ending_gear.rotv != 0:
		time_done += delta
		if time_done > 1.5:
			get_node('/root/global').level += 1
			get_tree().change_scene('res://base.tscn')
	else:
		time_done = 0
