extends VBoxContainer

@onready var ch1: Button = $CH1BTN
@onready var ch2: Button = $CH2BTN
@onready var ch3: Button = $CH3BTN

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ch1.mouse_entered.connect(_on_button_hovered.bind([ch2, ch3]))
	ch1.mouse_exited.connect(_on_button_unhovered.bind([ch2, ch3]))
	
	
func _on_button_hovered(others:Array) -> void:
	for b in others:
		b.visible = false
		
func _on_button_unhovered(others:Array) -> void:
	for b in others:
		b.visible = true
