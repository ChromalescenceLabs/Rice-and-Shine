extends Area2D
@onready var batter_cup_ready: Sprite2D = $MCup
@onready var batter_cup_filled: Sprite2D = $MCupFilled
@onready var batter_cup_emptied: Sprite2D = $MCupEmptied
var batterChange : bool = false

func _ready() -> void:
	batter_cup_ready.visible = true

func _process(_delta: float) -> void:
		batter_cup_filled.visible = true
		self.global_position = lerp(self.global_position, get_global_mouse_position(), 0.2)
	
func _input(event: InputEvent) -> void:
	if event.is_action_released("Click"):
		if batterChange: 
			get_node("../Pan").PancakeS1 = true
		self.queue_free()

func _on_area_entered(area: Area2D) -> void:
	if area is PancakePan:
		batterChange = true

func _on_area_exited(area: Area2D) -> void:
	if area is PancakePan:
		batterChange = false
