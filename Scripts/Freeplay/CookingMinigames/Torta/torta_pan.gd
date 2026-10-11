extends Area2D
class_name TortaPan
@onready var no_oil: Sprite2D = $NoOil
@onready var pan_oil: Sprite2D = $HasOil

var has_obj : bool = false
var has_oil : bool = false

func oiled() -> void:
	has_oil = true
	pan_oil.visible = true
	no_oil.visible = false

func unoil() -> void:
	has_oil = false
	no_oil.visible = true
	pan_oil.visible = false
	
