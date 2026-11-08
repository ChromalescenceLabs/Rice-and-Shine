extends VBoxContainer

func _ready() -> void:
	for child in get_children():
		if child is VBoxContainer: child.button.pressed.connect(press.bind(child)) # Using 'pressed' is usually cleaner than button_down for clicks

func press(button):
	var openedqty : int = 0
	
	for child in get_children():
		if child is VBoxContainer: 
			if child.opened: openedqty += 1
			
	if openedqty > 1:
		for child in get_children():
			if child is VBoxContainer: 
				if child.opened and not child == button: child.button.close_desc()
