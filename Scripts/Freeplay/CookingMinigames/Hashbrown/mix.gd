extends Node2D
@onready var mixer: Area2D = $mixer

func _process(_delta: float) -> void:
	if mixer.areaEnter:
		if mixer.areaEnter.name.to_lower() == "bowl":
			print("your ugly")
			
			for child in mixer.areaEnter.get_children():
				if child is TextureRect:
					print(child)
			await get_tree().create_timer(1).timeout

func _on_mixer_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			mixer.hold = true
			mixer.set_process(true)
			mixer.rotation_degrees=0
			if mixer.areaEnter:
				if mixer.areaEnter.name.to_lower() == "bowl":
					print("your ugly")
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
