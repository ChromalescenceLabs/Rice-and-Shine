extends Node2D
@onready var bowl_contents_unmixed: TextureRect = $BowlArea/BowlContentsUnmixed
@onready var bowl_contents_mixed: TextureRect = $BowlArea/BowlContentsMixed
var mouse_down : bool = false

func _ready() -> void:
	set_process_input(false)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Click"):
		mouse_down = true
	elif event.is_action_released("Click"):
		mouse_down = false

func _process(_delta: float) -> void:
	if abs(Input.get_last_mouse_velocity()) > Vector2(800, 800) and mouse_down and not bowl_contents_mixed.modulate.a >= 1: mix()
	
func mix():
	bowl_contents_unmixed.rotation_degrees += 5
	bowl_contents_mixed.rotation_degrees += 5
	
	bowl_contents_mixed.modulate.a += 0.005
	
	if bowl_contents_mixed.modulate.a >= 1:
		GlobalVars.successind(get_tree().current_scene)
		await GlobalVars.successIndEnd
		
		get_tree().current_scene.mixing_finished.emit()

func _on_lumpia_pouring_finished() -> void:
	set_process_input(true)
