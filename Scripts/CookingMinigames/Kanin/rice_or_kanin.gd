extends Node2D
@onready var rice_cups: Node2D = $RiceCups
@onready var rice_cont_closed: TextureButton = $RiceCups/RiceCont/RiceContClosed
@onready var rice_cont_opened: TextureRect = $RiceCups/RiceCont/RiceContOpened

@onready var water: Node2D = $Water

const SUCCIND = preload("uid://beppy36ki8xum")

const RICE_CUP = preload("uid://cpvm4q1ywd7h5")
var rice_cup_pos : Vector2
var riceContMonitoring : bool = false

func _ready() -> void:
	rice_cups.position.x += get_viewport().get_visible_rect().size.x
	
	item_enter(rice_cups)

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
	var success = SUCCIND.instantiate()
	success.global_position = get_viewport().size / 2
	add_child(success)
	
	await success.tree_exited
	
	item_exit(rice_cups)
	
func item_enter(item) -> void:
	create_tween().tween_property(item, "position", Vector2(0,0), 2).set_trans(Tween.TRANS_ELASTIC)
	
func item_exit(item) -> void:
	var vw = get_viewport().get_visible_rect().size.x
	create_tween().tween_property(item, "position", Vector2(vw * -1, 0), 2).set_trans(Tween.TRANS_ELASTIC)
	
