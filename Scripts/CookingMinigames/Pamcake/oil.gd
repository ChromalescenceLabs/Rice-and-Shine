extends Area2D

@onready var oil_open: Sprite2D = $OilOpened
@onready var oil_closed: Sprite2D = $OilClosed

var dragging: bool = false

func _ready() -> void:
	oil_closed.visible = true

func _process(_delta: float) -> void:
		if dragging: self.global_position = lerp(self.global_position, get_global_mouse_position(), 0.2)

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("Click"):
		dragging = true
		oil_open.visible = true
		oil_closed.visible = false
		
	if event.is_action_released("Click"):
		dragging = false
		oil_closed.visible = true
		oil_open.visible = false
		
# Return to original position
		


func _on_area_entered(area: Area2D) -> void:
	if area is PancakePan:
		if area.has_oil == false:
			if not dragging:
				return
				
			if dragging:
				area.has_oil = true
				area.oiled()
