extends Area2D
class_name Wrap
signal wrap_finished

var folded_right : bool = false
var folded_left : bool = false
var folded_forward : int = 0

var allow_wrapping : bool = false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Click"):
		if Input.get_last_mouse_velocity().x > 800 and not folded_right:
			fold_right()
		elif Input.get_last_mouse_velocity().x < 800 and not folded_left:
			fold_left()
		elif Input.get_last_mouse_velocity().y < 800 and not folded_forward >= 3:
			fold_forward()
			

func fold_right():
	# Add Texture Change Logic
	folded_right = true

func fold_left():
	if not folded_left:
		# Add Texture Change Logic
		folded_left = true
	
func fold_forward():
	if not folded_forward:
		# Add Texture Change Logic
		folded_forward += 1
		
		if folded_forward >= 3:
			set_process_input(false)
			GlobalVars.successind(get_tree().current_scene)
			await GlobalVars.successIndEnd
			
			GlobalVars.item_exit(self)
			await GlobalVars.itemExited
			
			wrap_finished.emit()
			self.queue_free()
