extends Area2D
var hold = false
var ogPos=position
var grated
var areaEnter

func _ready() -> void:
	set_process(false)

func _process(_delta: float) -> void:
	if hold:
		global_position = lerp(global_position, get_global_mouse_position(), 0.2)
	else:
		global_position = lerp(global_position, ogPos, 0.05)

func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			hold = true
			if not event.pressed:
				if areaEnter.name.to_lower() == "pan":
					if areaEnter.has_oil:
						grated=areaEnter.find_child("Grated")
						grated.visible=true
					else:
						var t = create_tween()
						t.tween_property(areaEnter, "position:x", areaEnter.position.x+30, .1).set_trans(Tween.TRANS_CUBIC)
						t.tween_property(areaEnter, "position:x", areaEnter.position.x-30, .1).set_trans(Tween.TRANS_CUBIC)
						t.tween_property(areaEnter, "position:x", areaEnter.position.x, .1).set_trans(Tween.TRANS_CUBIC)
				hold = false

func _on_mouse_entered() -> void:
	set_process(true)

func _on_area_entered(area: Area2D) -> void:
	if area.name.to_lower() == "pan":
		areaEnter=area
	else:
		areaEnter=null
