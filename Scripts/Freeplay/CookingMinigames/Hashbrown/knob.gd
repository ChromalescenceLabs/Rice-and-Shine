extends Area2D
var hold = false
var ogPos=position
var newPos
var canHold=false

func _process(_delta: float) -> void:
	if hold and get_global_mouse_position().y<ogPos.y and get_global_mouse_position().y>375:
		print('hello')
		global_position.y = lerp(global_position.y, get_global_mouse_position().y, 0.2)
	else:
		global_position.y = lerp(global_position.y, ogPos.y, 0.05)

func _on_area_entered(area: Area2D) -> void:
	if area.name=="end":
		ogPos=area.position


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and canHold:
			hold = true
			if not event.pressed:
				hold = false
				canHold=false

func _on_mouse_entered() -> void:
	canHold=true
