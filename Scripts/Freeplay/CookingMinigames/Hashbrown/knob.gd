extends Area2D
signal pulled
@onready var end: Area2D = $"../end"

var hold = false
var ogPos=position
var canHold=false

func _process(_delta: float) -> void:
	var mouse=get_local_mouse_position().y+position.y
	if hold and mouse<ogPos.y and mouse>end.position.y:
		position.y = lerp(position.y, mouse, 0.2)
	else:
		position.y = lerp(position.y, ogPos.y, 0.05)

func _on_area_entered(area: Area2D) -> void:
	if area.name=="end":
		pulled.emit()
		set_process_input(false)
		ogPos=area.position

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and canHold:
			hold = true
		if not event.pressed:
			hold = false
			if canHold:
				canHold=false

func _on_start_mouse_entered() -> void:
	canHold=true

func _on_start_mouse_exited() -> void:
	canHold=false
