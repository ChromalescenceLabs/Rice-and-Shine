extends Node2D

@onready var control: Control = $Control
#const BORDER = preload("uid://bqevegjdxbpb6")

var myChild=[]
var scene=0
var currentObject

func _ready() -> void:
	for child in get_children():
		if child is Node2D:
			print(child.name)
			child.position.x += get_viewport().get_visible_rect().size.x
			myChild.append(child)
	control.get_child(1).position.x += get_viewport().get_visible_rect().size.x
	GlobalVars.item_enter(myChild[scene])
	
# this code for child gets highlighted when mouse hover
# myChild is the parent scene so change that to whatever scene needs this
	#for child in myChild[scene].get_children():
		#if child is Area2D:
			#child.mouse_entered.connect(toggleHighlight.bind(true, child))
			#child.mouse_exited.connect(toggleHighlight.bind(false, child))

#func toggleHighlight(state:bool, area):
	#for c in area.get_children():
		#if c is Sprite2D or c is AnimatedSprite2D or c is TextureRect:
			#if state==true:
				#c.material = ShaderMaterial.new()
				#c.material.shader = BORDER
			#else:
				#c.material = null

func nextScene(exit, enter):
	GlobalVars.successind(self)
	await GlobalVars.successIndEnd
	GlobalVars.item_exit(exit)
	exit.set_process(false)
	exit.set_process_input(false)
	GlobalVars.item_enter(enter)
	scene+=1

func changeBG(goOut, goIn):
	var bgIn = control.get_child(goIn)
	var bgOut = control.get_child(goOut)
	
	bgIn.position.x = get_viewport().get_visible_rect().size.x
	bgIn.visible = true
	GlobalVars.item_exit(bgOut)
	GlobalVars.item_enter(bgIn)
	await GlobalVars.itemEntered
	bgOut.visible = false

func _on_peel_peeled() -> void:
	nextScene(myChild[scene],myChild[scene+1])

func _on_grated_full_grated() -> void:
	nextScene(myChild[scene],myChild[scene+1])

func _on_water_water_completed() -> void:
	nextScene(myChild[scene],myChild[scene+1])

func _on_squeeze_done() -> void:
	nextScene(myChild[scene],myChild[scene+1])
	await GlobalVars.successIndEnd
	changeBG(0,1)

func _on_bowl_done() -> void:
	nextScene(myChild[scene],myChild[scene+1])
	await GlobalVars.successIndEnd
	changeBG(1,0)

func _on_mix_done() -> void:
	nextScene(myChild[scene],myChild[scene+1])
	await GlobalVars.successIndEnd
	changeBG(0,1)

func _on_mixed_bowl_done() -> void:
	nextScene(myChild[scene],myChild[scene+1])

func _on_plate_done() -> void:
	GlobalVars.successind(self)
	await GlobalVars.successIndEnd
