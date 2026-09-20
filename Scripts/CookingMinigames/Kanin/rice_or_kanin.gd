extends Node2D

signal RiceCookerSection
signal waterSection

@onready var rice_cups: Node2D = $RiceCups
@onready var rice_cont_closed: TextureButton = $RiceCups/RiceCont/RiceContClosed
@onready var rice_cont_opened: TextureRect = $RiceCups/RiceCont/RiceContOpened

@onready var water: Node2D = $Water

@onready var rice_cooker: Node2D = $RiceCooker
@onready var rice_cooker_col: Area2D = $RiceCooker/RiceCooker/RiceCookerCol

@onready var water_rice_bowl: Node2D = $Water/RiceBowl

const RICE_CUP = preload("uid://cpvm4q1ywd7h5")
var rice_cup_pos : Vector2
var riceContMonitoring : bool = false

func _ready() -> void:
	rice_cups.position.x += get_viewport().get_visible_rect().size.x
	water.position.x += get_viewport().get_visible_rect().size.x
	rice_cooker.position.x += get_viewport().get_visible_rect().size.x
	
	GlobalVars.item_enter(rice_cups)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Click"):
		if riceContMonitoring:
			var rcup = RICE_CUP.instantiate()
			rcup.global_position = get_global_mouse_position()
			rice_cups.add_child(rcup)

#RiceContLogic
func _on_rice_cont_closed_pressed() -> void:
	rice_cont_opened.visible = true
	rice_cont_closed.visible = false
	rice_cont_closed.mouse_filter = Control.MOUSE_FILTER_IGNORE
	rice_cont_opened.mouse_filter = Control.MOUSE_FILTER_PASS

func _on_rice_cont_opened_mouse_entered() -> void:
	set_process_input(true)
	riceContMonitoring = true


func _on_rice_cont_opened_mouse_exited() -> void:
	set_process_input(false)
	riceContMonitoring = false
	

func _on_rice_bowl_rice_cup_done() -> void:
	GlobalVars.successind(self)
	
	await GlobalVars.successIndEnd
	
	GlobalVars.item_exit(rice_cups)
	waterSection.emit()


func _on_water_section() -> void:
	GlobalVars.item_enter(water)

func _on_water_water_completed() -> void:
	water_rice_bowl.reparent(self)
	
	GlobalVars.successind(self)
	water_rice_bowl.process_mode = Node.PROCESS_MODE_DISABLED
	
	await GlobalVars.successIndEnd
	
	GlobalVars.item_exit(water)
	RiceCookerSection.emit()


func _on_rice_cooker_section() -> void:
	GlobalVars.item_enter(rice_cooker)
	
	water_rice_bowl.process_mode = Node.PROCESS_MODE_INHERIT
	


func _on_rice_cooker_rice_cooker_done() -> void:
	GlobalVars.successind(self)
	
	await GlobalVars.successIndEnd
	GlobalVars.item_exit(rice_cooker)
	
	SceneLoader.load_scene("uid://b5ufcgv0qaktk", 1)
