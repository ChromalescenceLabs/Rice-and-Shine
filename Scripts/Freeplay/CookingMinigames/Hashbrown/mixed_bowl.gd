extends Area2D
@onready var mold: Area2D = $"../mold"

var onPlate=false
var plate=false

func _process(_delta: float) -> void:
	if onPlate && plate && abs(get_global_mouse_position().y - mold.ogPos.y) < 100.0:
		mold.position.y = lerp(mold.position.y, get_global_mouse_position().y, 0.2)
	else:
		mold.position = mold.position.lerp(mold.ogPos, 0.05) 

func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed("Click") && not onPlate:
		mold.hold=true
		mold.visible=true
		mold.set_process(true)

func _on_mold_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_released("Click") && not onPlate:
		mold.hold=false
		mold.visible=false
		if mold.areaEnter && mold.areaEnter.name.to_lower() == "plate":
			mold.ogPos=mold.areaEnter.position
			onPlate=true
			mold.visible=true


func _on_plate_mouse_entered() -> void:
	plate=true


func _on_plate_mouse_exited() -> void:
	plate=false
