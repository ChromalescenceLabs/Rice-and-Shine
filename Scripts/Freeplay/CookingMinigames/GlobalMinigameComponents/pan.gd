class_name CookingPan extends Area2D
@onready var normal: TextureRect = $Normal
@onready var oiled: TextureRect = $Oiled
var has_oil := false 
var is_occupied := false

func _on_area_entered(area: Area2D) -> void:
	match area: 
		Oil: if not has_oil: oil()
			
func oil() -> void:
	has_oil = true
	oiled.visible = true
	normal.visible = false

func unoil() -> void:
	has_oil = false
	normal.visible = true
	oiled.visible = false
	
