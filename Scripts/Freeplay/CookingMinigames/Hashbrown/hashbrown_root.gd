extends Node2D

@onready var control: Control = $Control
const BORDER = preload("uid://bqevegjdxbpb6")

var myChild=[]
var scene=3

func _ready() -> void:
	for child in get_children():
		if child is Node2D:
			print(child.name)
			child.position.x += get_viewport().get_visible_rect().size.x
			myChild.append(child)
	control.get_child(1).position.x += get_viewport().get_visible_rect().size.x
	GlobalVars.item_enter(myChild[scene])

func nextScene(exit, enter):
	GlobalVars.successind(self)
	await GlobalVars.successIndEnd
	GlobalVars.item_exit(exit)
	exit.set_process(false)
	GlobalVars.item_enter(enter)
	scene+=1

func _on_peel_peeled() -> void:
	nextScene(myChild[scene],myChild[scene+1])

func _on_grated_full_grated() -> void:
	nextScene(myChild[scene],myChild[scene+1])

func _on_water_water_completed() -> void:
	nextScene(myChild[scene],myChild[scene+1])

func _on_squeeze_done() -> void:
	nextScene(myChild[scene],myChild[scene+1])
	await GlobalVars.successIndEnd
	GlobalVars.item_exit(control.get_child(0))
	GlobalVars.item_enter(control.get_child(1))

func _on_bowl_done() -> void:
	nextScene(myChild[scene],myChild[scene+1])
