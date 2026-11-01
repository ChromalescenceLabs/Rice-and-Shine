extends Area2D
@onready var mold: Area2D = $"../mold"
@onready var progress_bar_change_time: Timer = $"../mold/ProgressBarChangeTime"

var onPlate=false
var plate=false
var current_velocity
var nextMold = false
var molded=0

signal done

func _process(_delta: float) -> void:
	current_velocity = Input.get_last_mouse_velocity().y
	if molded >= 3:
		progress_bar_change_time.stop()
		return

	if onPlate:
		if plate && abs(get_global_mouse_position().y - mold.ogPos.y) < 150.0 && abs(current_velocity) < 1000:
			mold.position.y = lerp(mold.position.y, get_global_mouse_position().y, 0.2)
		else:
			mold.position = mold.position.lerp(mold.ogPos, 0.05) 
			progress_bar_change_time.start()
	else:
		progress_bar_change_time.stop()

func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed("Click") && not onPlate && molded < 3:
		mold.hold=true
		mold.visible=true
		mold.set_process(true)

func _on_mold_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_released("Click") && not onPlate:
		mold.visible=false
		mold.hold=false
		if mold.areaEnter && mold.areaEnter.name.to_lower() == "plate":
			mold.ogPos=mold.areaEnter.position
			onPlate=true
			mold.visible=true

func _on_mold_mouse_entered() -> void:
	plate=true

func _on_mold_mouse_exited() -> void:
	plate=false

func _on_progress_bar_change_time_timeout() -> void:
	if molded >= 3:
		progress_bar_change_time.stop()
		return

	var children = mold.get_children()
	if abs(current_velocity) > 500:
		for i in range(children.size() - 1):
			var curChild = children[i]
			var nextChild = children[i + 1]

			if curChild is TextureRect and curChild.modulate.a  > 0 and curChild.modulate.a  < 1:
				curChild.modulate.a = clampf(curChild.modulate.a - .2, 0, 1)
				nextChild.modulate.a = clampf(nextChild.modulate.a + .2, 0, 1)
				break 
			elif nextChild is TextureRect:
				if curChild is TextureRect and is_equal_approx(curChild.modulate.a, 1) and nextChild.modulate.a < 1:
					curChild.modulate.a = clampf(curChild.modulate.a - .2, 0, 1)
					nextChild.modulate.a = clampf(nextChild.modulate.a + .2, 0, 1)
					break

		if not nextMold and children.size() > 2 and children[2].modulate.a >= 1:
			molded += 1
			print(molded)
			nextMold = true
			GlobalVars.item_exit(mold)
			onPlate = false
			if molded < 3: GlobalVars.itemExited.connect(moldAgain)
			else:
				print("done")
				done.emit()
				set_process(false)

func moldAgain():
	mold.visible = false
	
	if molded >= 3:
		return
		
	print("im out")
	nextMold = false
	mold.ogPos = Vector2(963, 366)
	for child in mold.get_children():
		var index = mold.get_children().find(child)
		if child is TextureRect:
			child.modulate.a = 1 if index == 0 else 0
	
