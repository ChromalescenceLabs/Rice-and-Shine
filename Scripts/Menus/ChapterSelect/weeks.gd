extends Node2D

var canPressNext=true
var highlight=ColorRect.new()

func _ready() -> void:
	#just makes it so that it randomizes the rotation each time
	for child in get_children():
		var index = get_children().find(child)

		if index == 0 or index == 6:
			child.rotation_degrees=20
			print(child.name, child.rotation_degrees)
			child.position.x-=-10
		else:
			child.rotation_degrees=randi_range(-20,10)
			print(child.name, child.rotation_degrees)

func animFrontToBack():
	#var highloght=ColorRect.new()
	canPressNext=false
	var frontChild= get_child(-1)
	var FOrigPos=frontChild.position
	var backChild= get_child(0)

	#animation for the front polaroid
	create_tween().tween_property(frontChild, "position:x", frontChild.position.x+50, .5).set_trans(Tween.TRANS_CUBIC)
	await get_tree().create_timer(.3).timeout
	create_tween().tween_property(frontChild, "position:x", backChild.position.x, .5).set_trans(Tween.TRANS_CUBIC)

	#just moves every polaroid index number except the front forward
	for child in get_children():
		var index = get_children().find(child)
		move_child(child, index+1)
	
	#player physically seeing the movement of the polaroid forward (aka the animation)
	for child in get_children():
		var index = get_children().find(child)
		if child != frontChild:
			var t = create_tween()
			var nextChild= get_child(index+1)
			
			if nextChild == frontChild:
				t.tween_property(child, "position:x", FOrigPos.x, .5).set_trans(Tween.TRANS_CUBIC)
				#child.add_child(highlight)
				#highlight.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
				#highlight.scale=Vector2(1.2,1.2)
				#highlight.set_anchors_preset(Control.PRESET_CENTER)
				#highlight.show_behind_parent=true
				%highlight.reparent(child)
				%highlight.set_anchors_preset(Control.PRESET_CENTER)
				%highlight.global_position=child.position
				%highlight.show_behind_parent=true
			else:
				t.tween_property(child, "position:x", nextChild.position.x, .5).set_trans(Tween.TRANS_CUBIC)
			t.set_parallel()
			t.tween_property(child, "rotation", nextChild.rotation, .5).set_trans(Tween.TRANS_CUBIC)
			
			#this for lerp instead of tween but idk how to use it properly lol 
				#child.position=lerp(child.position, nextChild.position, .2)
				#child.rotation_degrees=nextChild.rotation_degrees
			
	move_child(frontChild, 0)
	#makes it so that player cant spam and break everything
	await get_tree().create_timer(.5).timeout
	canPressNext=true

func _on_forward_pressed() -> void:
	if canPressNext:
		animFrontToBack()
		#get_child(-1).remove_child(highlight)
		
