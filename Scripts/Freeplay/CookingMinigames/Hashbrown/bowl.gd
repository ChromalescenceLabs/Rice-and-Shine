extends Area2D
@onready var potato: Area2D = $"../potato"
@onready var grated_top: TextureRect = $GratedTop
@onready var fried_top: TextureRect = $FriedTop
@onready var bowl_top: TextureRect = $BowlTop
@onready var pan: Area2D = $"../Pan"


func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed("Click"):
		if not potato.frying:
			potato.visible=true
			potato.hold = true
			bowl_top.visible=true

func _on_potato_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_released("Click"):
		potato.visible=false
		potato.hold = false
		bowl_top.visible=false
		if potato.frying:
			pan.find_child("Grated").visible=true
			


func _on_pan_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed("Click") and pan.fried:
		potato.position=pan.position
		potato.modulate=Color(4.937, 0.914, 0.503, 1.0)
		potato.visible=true
		potato.hold = true
		pan.find_child("Grated").visible=false
