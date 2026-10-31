class_name Oil extends Area2D

@onready var oil_open: Sprite2D = $OilOpened
@onready var oil_closed: Sprite2D = $OilClosed

var dragging: bool = false
var og_pos : Vector2
# Change this if the bowl should snap to its original position
var snap_to_og_pos := false
# Call this function, passing the desired og pos in the parameter to set its original position
func set_og_pos(pos : Vector2 = self.global_position): og_pos = pos

func _ready() -> void:
	og_pos = position
	oil_closed.visible = true

func _process(_delta: float) -> void:
		if dragging: self.global_position = lerp(self.global_position, get_global_mouse_position(), 0.2)

func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed("Click"):
		dragging = true
		oil_open.visible = true
		oil_closed.visible = false
	elif event.is_action_released("Click"):
		dragging = false
		oil_closed.visible = true
		oil_open.visible = false
		if snap_to_og_pos: self.global_position = og_pos

func _on_area_entered(area: Area2D) -> void:
	if area is CookingPan:
		area.oil()
