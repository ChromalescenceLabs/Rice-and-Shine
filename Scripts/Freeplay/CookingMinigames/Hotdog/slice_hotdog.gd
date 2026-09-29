extends Area2D

signal slice 


@export var textures: Array[Sprite2D] = []
@onready var detector: TextureRect = $Detector

var mouse_velocity

var passed_through: bool = false
var mouse_hold: bool = false

var slice_count: int = 0
var root
var plate

func _ready() -> void:
	root = get_tree().current_scene

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			mouse_hold = true
			if not event.pressed:
				mouse_hold = false
				var current_velocity = Input.get_last_mouse_velocity().x
				
				if abs(current_velocity) > 1500 and passed_through:
					slice.emit()
				
				passed_through = false
		

func _on_raw_3_mouse_entered() -> void:
	passed_through = true

func _on_raw_3_mouse_exited() -> void:
	if not mouse_hold: passed_through = false


func _on_slice() -> void:
	textures[slice_count].visible = true
	slice_count += 1
	
	if slice_count == 3:
		detector.mouse_filter = Control.MOUSE_FILTER_IGNORE
		GlobalVars.successind(root)
		await GlobalVars.successIndEnd
		
		root.sliced_hotdog += 1
		plate = get_tree().current_scene.plate
		
		match root.sliced_hotdog:
			1: create_tween().tween_property(self, "position", Vector2(plate.position.x - 100, plate.position.y), 0.5).set_trans(Tween.TRANS_SINE)
			2: create_tween().tween_property(self, "position", plate.position, 0.5).set_trans(Tween.TRANS_SINE)
			3: create_tween().tween_property(self, "position", Vector2(plate.position.x + 100, plate.position.y), 0.5).set_trans(Tween.TRANS_SINE)
