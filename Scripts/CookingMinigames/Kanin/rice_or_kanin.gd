extends Node2D
@onready var rice_cups: Node2D = $RiceCups
@onready var rice_cont_closed: TextureButton = $RiceCups/RiceCont/RiceContClosed
@onready var rice_cont_opened: TextureRect = $RiceCups/RiceCont/RiceContOpened

const RICE_CUP = preload("uid://cpvm4q1ywd7h5")
var rice_cup_pos : Vector2
var riceContMonitoring : bool = false

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
