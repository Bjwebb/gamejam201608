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

func load_new_level():
	get_tree().change_scene(global.level_scenes[global.level])

func _input(event):
	var global = get_node('/root/global')
	if event.is_action_pressed('ui_select'):
		load_new_level()
	elif event.is_action_pressed('ui_page_up'):
		global.level += 1
		load_new_level()
	elif event.is_action_pressed('ui_page_down'):
		global.level -= 1
		load_new_level()

func _process(delta):
	for gear in gears:
		gear.rotv = 0
	starting_gear.rotv = 1
	starting_gear.tree_process()
	
	if ending_gear.rotv != 0:
		time_done += delta
		if time_done > 1.5:
			global.level += 1
			load_new_level()
	else:
		time_done = 0
