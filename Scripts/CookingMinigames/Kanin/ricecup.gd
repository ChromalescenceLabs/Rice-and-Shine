extends Area2D
@onready var rice_cup_filled: Sprite2D = $RiceCupFilled
var riceAmtChange : bool = false

func _ready() -> void:
	rice_cup_filled.visible = true

func _process(_delta: float) -> void:
		rice_cup_filled.visible = true
		self.global_position = lerp(self.global_position, get_global_mouse_position(), 0.2)
	
func _input(event: InputEvent) -> void:
	if event.is_action_released("Click"):
		if riceAmtChange:
			get_node("../RiceBowl").riceAmt += 1
		self.queue_free()

func _on_area_entered(area: Area2D) -> void:
	if area is RiceBowl:
		riceAmtChange = true

func _on_area_exited(area: Area2D) -> void:
	if area is RiceBowl:
		riceAmtChange = false
