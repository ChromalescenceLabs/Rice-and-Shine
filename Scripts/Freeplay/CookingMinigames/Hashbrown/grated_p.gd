extends Area2D
var hold = false
var ogPos=position
var hasBeenPut=false
var canHold=false

func _ready() -> void:
	visible=false

func _process(_delta: float) -> void:
	if hold:
		global_position = lerp(global_position, get_global_mouse_position(), 0.2)
	else:
		global_position = lerp(global_position, ogPos, 0.05)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and canHold:
			hold = true
			visible=true
		if not event.pressed:
			hold = false
			visible=false
			canHold=false


func _on_bowl_mouse_entered() -> void:
	canHold=true
