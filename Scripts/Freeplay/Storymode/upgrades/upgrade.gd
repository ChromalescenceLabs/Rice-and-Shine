extends VBoxContainer
@onready var description: RichTextLabel = $DescCont/description
@onready var desc_cont: Control = $DescCont

var curButton = null
var desc_tween : Tween

func _ready() -> void:
	# Hide description by default and set its height to 0
	desc_cont.custom_minimum_size.y = 0.0
	description.custom_maximum_size.y = -1.0
	description.visible = false
	
	for child in get_children():
		if child is Button: child.pressed.connect(press.bind(child)) # Using 'pressed' is usually cleaner than button_down for clicks

func press(button):
	# If clicking the exact same button again, close it
	if curButton == button:
		if desc_tween and desc_tween.is_running(): desc_tween.kill()
		
		desc_tween = create_tween()
		desc_tween.tween_property(description, "custom_maximum_size:y", 0, 0.5).set_trans(Tween.TRANS_CUBIC)
		create_tween().tween_property(desc_cont, "custom_minimum_size:y", 0.0, 0.5).set_trans(Tween.TRANS_CUBIC)
		await desc_tween.finished
		description.custom_maximum_size.y = -1.0
		description.visible = false
		curButton = null
		return

	# 1. Get the correct index of the button *ignoring* the description node itself
	#var index = 0
	#for i in range(get_child_count()):
		#if get_child(i) == button:
			#index = i
			#break
	
	# Optional: update text here based on button.name if needed
	
	# 2. Move the description right after the button (+1)
	#move_child(description, index + 1)
	
	# 3. Animate to the required height
	var target_height = description.size.y
	description.custom_maximum_size.y = 0
	description.visible = true
	desc_tween = create_tween()
	desc_tween.tween_property(description, "custom_maximum_size:y", target_height, 0.5).set_trans(Tween.TRANS_CUBIC)
	create_tween().tween_property(desc_cont, "custom_minimum_size:y", target_height, 0.5).set_trans(Tween.TRANS_CUBIC)
	
	curButton = button

func release(button): pass
