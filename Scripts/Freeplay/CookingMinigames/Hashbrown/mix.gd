extends Node2D
@onready var mixer: Area2D = $mixer
@onready var bowl: Area2D = $"../Bowl"

@onready var origPosBowl: Vector2 = bowl.position
signal done

func _process(_delta: float) -> void:
		if mixer.hold && abs(get_global_mouse_position().x - origPosBowl.x) < 100.0:
			bowl.position.x = lerp(bowl.position.x, get_global_mouse_position().x, 0.2)
		else:
			bowl.position = bowl.position.lerp(origPosBowl, 0.05)


func _on_mixer_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			mixer.hold = true
			mixer.set_process(true)
			mixer.rotation_degrees=-60
			if not event.pressed:
				mixer.hold = false
				mixer.rotation_degrees=90

#
	#if event.is_action_pressed("Click"):
			#mixer.hold = true
			#mixer.set_process(true)
			#mixer.rotation_degrees=0
			#if mixer.areaEnter:
				#if mixer.areaEnter.name.to_lower() == "bowly":
					#print("your ugly")
	#if event.is_action_released("Click"):
			#mixer.hold = false
			#mixer.rotation_degrees=90

func _on_bowl_mouse_exited() -> void:
	if abs(Input.get_last_mouse_velocity().x) > 1000 &&  bowl.get_child(1).modulate.a<1:
		mix()
		if bowl.get_child(1).modulate.a>=1:
			done.emit()
	
func mix():
	for child in bowl.get_children():
		if child is TextureRect && visible:
			if child.name != "mixed" && child.name != "bowl":
				child.modulate.a-=0.05
			elif child.name != "bowl":
				if not child.visible:
					child.visible=true
					child.modulate.a=0
				child.modulate.a+=0.05
