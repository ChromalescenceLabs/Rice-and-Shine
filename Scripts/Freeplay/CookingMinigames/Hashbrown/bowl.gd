extends Area2D
signal done
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
		#grated on pan
		if potato.areaEnter.name.to_lower() == "pan":
			if potato.areaEnter.has_oil:
				var grated=potato.areaEnter.find_child("Grated")
				grated.visible=true
				potato.frying=true
			elif not potato.frying:
				GlobalVars.shake(potato.areaEnter)
				
		potato.hold = false
		
		#fried on bowl
		if potato.frying:
			pan.find_child("Grated").visible=true
			if potato.areaEnter.name=="Bowl":
				fried_top.visible=true
				bowl_top.visible=false
				pan.find_child("Grated").visible=false
				done.emit()
		elif not potato.frying:
			bowl_top.visible=false


func _on_pan_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed("Click") and pan.fried and not fried_top.visible:
		potato.position=pan.position
		potato.modulate=Color(4.937, 0.914, 0.503, 1.0)
		potato.visible=true
		potato.hold = true
		pan.find_child("Grated").visible=false
