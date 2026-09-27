extends Area2D
class_name HdogPan

@onready var pan_empty: Sprite2D = $Pan
@onready var pan_oiled: Sprite2D = $PanOil

var has_hdog: bool = false
var has_oil: bool = false


func _ready() -> void:
	pass
	
func oiled() -> void:
	if has_oil == true:
		pan_oiled.visible = true
		pan_empty.visible = false
