extends Area2D

@onready var oil_open: Sprite2D = $OilOpened
@onready var oil_closed: Sprite2D = $OilClosed

var open: bool = false
var dragging: bool = false

func _ready() -> void:
	oil_open.visible = true

func _process(_delta: float) -> void:
		if dragging: self.global_position = lerp(self.global_position, get_global_mouse_position(), 0.2)

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("Click"):
		dragging = true
		
	if event.is_action_released("Click"):
		dragging = false
		
#add return to original position code next



func oil() -> void:
	oil_open.visible = open == true
	oil_closed.visible = open == false


func _on_area_entered(area: Area2D) -> void:
	if area is PancakePan:
		if not dragging:
			return
			
		if dragging:
			area.pan_oiled.visible
			
		
# func _on_area_entered(area: Area2D) -> void:
#	if area is PancakePan:
