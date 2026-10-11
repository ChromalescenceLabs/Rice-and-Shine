extends Area2D

@onready var bowl: Area2D = $"../bowl"
@onready var put_on_cloth: Area2D = $"../putOnCloth"
@onready var scroll_1: Node2D = $"../scroll1"

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
			
			if canHold:
				canHold=false
			
			if hasBeenPut==true:
				print("done")
				bowl.get_child(0).visible=true
				bowl.get_child(1).visible=false
				put_on_cloth.get_child(0).visible=false
				put_on_cloth.get_child(1).visible=true
				scroll_1.visible=true
				set_process_input(false)

func _on_bowl_mouse_entered() -> void:
	canHold=true

func _on_bowl_mouse_exited() -> void:
	canHold=false

func _on_area_entered(area: Area2D) -> void:
	if area.name=="putOnCloth":
		hasBeenPut=true
