extends TextureRect

@export var sticknode1 : Node2D
@export var sticknode2 : Node2D
@export var sticknode3 : Node2D
const STICK_COMPS = preload("uid://brd3lmuj2umok")
var touching: bool = false
var current_stick

func _ready() -> void:
	get_tree().process_frame
	current_stick = sticknode1
	get_tree().current_scene.change_stick.connect(check_stick_amt)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Click") and touching:
		var stick_comps = STICK_COMPS.instantiate()
		stick_comps.type = "Mallow"
		stick_comps.position = get_global_mouse_position()
		current_stick.add_child(stick_comps)

func _on_mouse_entered() -> void: touching = true
func _on_mouse_exited() -> void: touching = false

func check_stick_amt():
	match get_tree().current_scene.sticks:
		1: current_stick = sticknode2
		2: current_stick = sticknode3
