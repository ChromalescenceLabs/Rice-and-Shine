extends Area2D
signal done
@onready var potato: Area2D = $"../potato"
@onready var grated_top: TextureRect = $GratedTop
@onready var fried_top: TextureRect = $FriedTop
@onready var bowl_top: TextureRect = $BowlTop
@onready var pan: Area2D = $"../Pan"
@onready var oil: Oil = $"../Oil"
@onready var grated: TextureRect = $"../Pan/Grated"
@onready var progress_bar_change_time: Timer = $"../ProgressBar/ProgressBarChangeTime"
@onready var progress_bar: ProgressBar = $"../ProgressBar"

var fried = false

func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed("Click"):
		if not potato.frying:
			potato.visible=true
			potato.hold = true
			bowl_top.visible=true

func _on_potato_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_released("Click"):
		potato.visible=false
		if potato.areaEnter:
			#grated on pan
			if potato.areaEnter.name.to_lower() == "pan":
				if potato.areaEnter.has_oil:
					grated.visible=true
					potato.frying=true
				elif not potato.frying:
					GlobalVars.shake(potato.areaEnter)
				
			potato.hold = false
		
			#fried on bowl
			if potato.frying:
				pan.find_child("Grated").visible=true
				if potato.areaEnter.name=="Bowl":
					fried_top.visible=true
					bowl_top.visible=false
					pan.find_child("Grated").visible=false
					done.emit()
			elif not potato.frying:
					bowl_top.visible=false
		elif potato.frying: pan.find_child("Grated").visible=true
		elif not potato.frying: bowl_top.visible=false

func _on_pan_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed("Click") and fried and not fried_top.visible:
		potato.position=pan.position
		potato.modulate=Color(4.937, 0.914, 0.503, 1.0)
		potato.visible=true
		potato.hold = true
		pan.find_child("Grated").visible=false

func _on_grated_visibility_changed() -> void:
	progress_bar.visible=true
	progress_bar_change_time.start()
	if not potato.frying:
		find_child("BowlTop").visible=true

func _on_progress_bar_change_time_timeout() -> void:
	if progress_bar.value<100:
		progress_bar.value+=1
		grated.modulate = grated.modulate.lerp(Color(4.937, 0.914, 0.503, 1.0), .03)
		
	elif progress_bar.value==100:
		progress_bar_change_time.stop() 
		GlobalVars.shake(progress_bar)
		if grated:
			create_tween().tween_property(progress_bar, "modulate:a", 0, .5).set_trans(Tween.TRANS_CUBIC)
			await get_tree().create_timer(.2).timeout
		progress_bar.visible=false
		fried=true
		pan.unoil()
