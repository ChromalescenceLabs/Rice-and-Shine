extends Area2D
class_name Wrap
signal wrap_finished

var folded_right : bool = false
var folded_left : bool = false
var folded_forward : int = 0

var allow_wrapping : bool = false

func _ready() -> void:
	set_process_input(false)
	get_parent().wrap_filled.connect(_on_wrapping_wrap_filled)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Click"):
		if Input.get_last_mouse_velocity().x > 800 and not folded_right:
			fold_right()
			fold_check()
		elif Input.get_last_mouse_velocity().x < 800 and not folded_left:
			fold_left()
			fold_check()
		elif Input.get_last_mouse_velocity().y < 800 and not folded_forward >= 3:
			fold_forward()
			fold_check()
			

func fold_right():
	print("folded to the right")
	# Add Texture Change Logic
	folded_right = true

func fold_left():
	print("folded to the left")
	# Add Texture Change Logic
	folded_left = true
	
func fold_forward():
	print("folded forward")
	# Add Texture Change Logic
	folded_forward += 1
	
func fold_check():
	if folded_forward >= 3 and folded_right and folded_left:
		set_process_input(false)
		GlobalVars.successind(get_tree().current_scene)
		await GlobalVars.successIndEnd
		
		GlobalVars.item_exit(self)
		await GlobalVars.itemExited
		
		wrap_finished.emit()
		self.queue_free()

func _on_wrapping_wrap_filled() -> void:
	set_process_input(true)
