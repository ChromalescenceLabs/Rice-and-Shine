extends Area2D
@onready var batter_cup_ready: Sprite2D = $MCup
@onready var batter_cup_filled: Sprite2D = $MCupFilled
@onready var batter_cup_emptied: Sprite2D = $MCupEmptied

enum CupState {READY, FILLED, EMPTY}

var cup_state: CupState = CupState.READY
var dragging: bool = false

func _ready() -> void:
	batter_cup_state()

func _process(_delta: float) -> void:
		if dragging: self.global_position = lerp(self.global_position, get_global_mouse_position(), 0.2)

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("Click"):
		dragging = true
		
	if event.is_action_released("Click"):
		dragging = false
		
#add return to original position code next



func batter_cup_state() -> void:
	batter_cup_ready.visible = cup_state == CupState.READY
	batter_cup_filled.visible = cup_state == CupState.FILLED
	batter_cup_emptied.visible = cup_state == CupState.EMPTY


func _on_area_entered(area: Area2D) -> void:
	if area is BatterBowl:
		if not dragging:
			return
			
		if cup_state == CupState.READY or cup_state == CupState.EMPTY:
			if area.batterLevel > 0:
				area.batterLevel -= 1
				
				cup_state = CupState.FILLED
				batter_cup_state()
			
			
	if area is PancakePan:
		if not dragging:
			return
			
		if cup_state == CupState.FILLED:
			cup_state = CupState.EMPTY
			batter_cup_state()
