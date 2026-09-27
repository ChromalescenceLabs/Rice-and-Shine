extends Area2D
class_name HdogPan

@onready var pan_empty: Sprite2D = $Pan
@onready var pan_oiled: Sprite2D = $PanOil
var has_oil: bool = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func oiled() -> void:
	if has_oil == true:
		pan_oiled.visible = true
		pan_empty.visible = false
