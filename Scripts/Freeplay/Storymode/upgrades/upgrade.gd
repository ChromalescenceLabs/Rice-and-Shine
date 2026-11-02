extends VBoxContainer
@onready var description: RichTextLabel = $description

var curButton = null

func _ready() -> void:
	# Hide description by default and set its height to 0
	description.custom_minimum_size.y = 0
	description.visible = false
	
	for child in get_children():
		if child is Button:
			child.pressed.connect(press.bind(child)) # Using 'pressed' is usually cleaner than button_down for clicks

func press(button):
	# If clicking the exact same button again, close it
	if curButton == button:
		var tween = create_tween()
		tween.tween_property(description, "custom_minimum_size:y", 0, 0.5).set_trans(Tween.TRANS_CUBIC)
		await tween.finished
		description.visible = false
		curButton = null
		return

	# 1. Get the correct index of the button *ignoring* the description node itself
	var index = 0
	for i in range(get_child_count()):
		if get_child(i) == button:
			index = i
			break

	# 2. Make sure description is visible before calculating height
	description.visible = true
	
	# Optional: update text here based on button.name if needed
	
	# 3. Move the description right after the button (+1)
	move_child(description, index + 1)
	
	# 4. Animate to the required height
	var target_height = description.get_content_height() + 10
	create_tween().tween_property(description, "custom_minimum_size:y", target_height, 0.5).set_trans(Tween.TRANS_CUBIC)
	
	curButton = button

func release(button): pass
