extends Area2D

signal slice 

@onready var detector: TextureRect = $Detector
var mouse_velocity
var passed_through: bool = false
var mouse_hold: bool = false
var slice_count: int = 0
@export var textures: Array[Sprite2D]

@onready var chopped: Node2D = $Chopped
@onready var texture_1: Sprite2D = $Unchopped/Texture1
@onready var texture_2: Sprite2D = $Unchopped/Texture2
@onready var texture_3: Sprite2D = $Unchopped/Texture3
@onready var texture_4: Sprite2D = $Unchopped/Texture4
@onready var texture_5: Sprite2D = $Unchopped/Texture5

var root

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


func _on_detector_mouse_entered() -> void:
	passed_through = true

func _on_detector_mouse_exited() -> void:
	if not mouse_hold: passed_through = false


func _on_slice() -> void:
	var texture = textures[slice_count]
	texture.reparent(chopped, true)
	create_tween().tween_property(chopped, "position:y", chopped.position.y - 20, 0.5).set_trans(Tween.TRANS_SINE)
	slice_count += 1
	
	if slice_count == 4:
		detector.mouse_filter = Control.MOUSE_FILTER_IGNORE
		GlobalVars.successind(root)
		await GlobalVars.successIndEnd
		
		root.chopped_hdog += 1
		
		var new_pos = self.position.x - get_viewport().get_visible_rect().size.x
		var tw = create_tween().tween_property(self, "position:x", new_pos, 1.5).set_trans(Tween.TRANS_ELASTIC)
		await tw.finished
		queue_free()
