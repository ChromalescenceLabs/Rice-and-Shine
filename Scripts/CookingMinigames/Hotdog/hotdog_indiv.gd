extends Area2D
class_name Hotdog

@onready var raw_unchopped: Sprite2D = $RawUnchopped
@onready var raw_1: Sprite2D = $Raw1
@onready var raw_2: Sprite2D = $Raw2
@onready var raw_3: Sprite2D = $Raw3
@onready var cooked: TextureRect = $Cooked

var dragging: bool = false

func _ready() -> void:
	set_process_input(false)
	cooked.modulate.a = 0
	
func _process(_delta: float) -> void:
	if dragging: self.global_position = lerp(self.global_position, get_global_mouse_position(), 0.2)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Click"):
		dragging = true
	elif event.is_action_released("Click"):
		dragging = false

func _on_cooked_mouse_entered() -> void:
	set_process_input(true)

func _on_cooked_mouse_exited() -> void:
	set_process_input(false)
