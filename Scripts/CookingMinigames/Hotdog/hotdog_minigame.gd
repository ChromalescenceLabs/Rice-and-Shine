extends Node2D

# FRYING
signal frying_finished
@onready var frying: Node2D = $Frying
@onready var hdog_pan: HdogPan = $Frying/HdogPan
var frying_hotdog_no: int = 3

func _ready() -> void:
	frying.position.x += get_viewport().get_visible_rect().size.x
	
	GlobalVars.item_enter(frying)


func _on_frying_finished() -> void:
	GlobalVars.item_exit(frying)
