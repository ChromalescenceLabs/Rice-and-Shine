extends Control

var canPressNext = true

func _ready() -> void:
	# Just makes it so that it randomizes the rotation each time
	for child in get_children():
		var index = get_children().find(child)

		if index == 0 or index == 6:
			child.rotation_degrees = 20
			print(child.name, child.rotation_degrees)
			child.position.x -= -10
			if index == 6:
				_update_shader(index, true)
			else:
				_update_shader(index, false)
		else:
			child.rotation_degrees = randi_range(-20, 10)
			print(child.name, child.rotation_degrees)
			_update_shader(index, false)

func _animate_carousel(forward: bool) -> void:
	canPressNext = false
	
	var frontChild = get_child(-1 if forward else 0)
	var FOrigPos = frontChild.position
	var backChild = get_child(0 if forward else -1)
	
	var multiplier = 1 if forward else -1
	create_tween().tween_property(frontChild, "position:x", frontChild.position.x + (50 * multiplier), .5).set_trans(Tween.TRANS_CUBIC)
	await get_tree().create_timer(.3).timeout
	create_tween().tween_property(frontChild, "position:x", backChild.position.x, .5).set_trans(Tween.TRANS_CUBIC)

	for child in get_children():
		var index = get_children().find(child)
		#moves child except front
		move_child(child, index + 1 if forward else index - 1)

	for child in get_children():
		var index = get_children().find(child)
		if child != frontChild:
			var t = create_tween()
			var nextChild = get_child(index + 1 if forward else index - 1)
			
			print(child.name, nextChild.name)
			
			if nextChild == frontChild:
				_update_shader(index, forward)
				t.tween_property(child, "position:x", FOrigPos.x, .5).set_trans(Tween.TRANS_CUBIC)
			else:
				_update_shader(index, false)
				t.tween_property(child, "position:x", nextChild.position.x, .5).set_trans(Tween.TRANS_CUBIC)
				
			t.set_parallel()
			t.tween_property(child, "rotation", nextChild.rotation, .5).set_trans(Tween.TRANS_CUBIC)
		else:
			# Front child gets highlighted
			_update_shader(index, true if not forward else false)

	move_child(frontChild, 0 if forward else -1)
	# Prevent spamming
	await get_tree().create_timer(.5).timeout
	canPressNext = true


func _update_shader(index: int, enable: bool) -> void:
	var selected_week = get_child(index)
	if selected_week and selected_week.material:
		selected_week.material.set_shader_parameter("enable_shader", enable)

	if enable:
		selected_week.modulate = Color.WHITE
	else: 
		selected_week.modulate = Color(0.332, 0.316, 0.292, 1.0)


func _on_back_pressed() -> void:
	if canPressNext:
		_animate_carousel(false)


func _on_forward_pressed() -> void:
	if canPressNext:
		_animate_carousel(true)
