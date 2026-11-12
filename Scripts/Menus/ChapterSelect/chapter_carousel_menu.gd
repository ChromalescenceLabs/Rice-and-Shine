extends Control

@onready var object_container: HBoxContainer = $PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/ScrollContainer/ObjectContainer
@onready var scroll_container: ScrollContainer = %ScrollContainer
@onready var hover: AnimationPlayer = $PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/Previous/Hover
@onready var hover_2: AnimationPlayer = $PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/Next/Hover2
@onready var previous: TextureButton = $PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/Previous
@onready var next: TextureButton = $PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/Next

var scroll_tween: Tween
var targetScroll = 0
var selected_indx : int = 0:
	set(value):
		selected_indx = value
		previous.modulate.a = 1
		next.modulate.a = 1
		if selected_indx == 0: 
			previous.modulate.a = 0
		elif selected_indx == 2: 
			next.modulate.a = 0

func _ready() -> void:
	_set_selection()
	
func _set_selection():
	await get_tree().create_timer(0.01).timeout
	_select_deselect_highlight(true)

func _on_previous_pressed() -> void:
	if selected_indx > 0:
		var scrollValue = targetScroll - _get_space_between()
		await _tween_scroll(scrollValue)
	
		selected_indx -= 1
		_select_deselect_highlight(false)

func _on_next_pressed() -> void:
	if selected_indx < 2:
		var scrollValue = targetScroll + _get_space_between()
		await _tween_scroll(scrollValue)
		
		selected_indx += 1
		_select_deselect_highlight(true)
	
	
func _get_space_between():
	var distanceSize = object_container.get_theme_constant("separation")
	var objectSize = object_container.get_children()[1].size.x
	
	return distanceSize + objectSize

func _tween_scroll(scrollValue):
	targetScroll = scrollValue
	if scroll_tween and scroll_tween.is_valid():
		scroll_tween.kill()
		
	scroll_tween = get_tree().create_tween()
	
	scroll_tween.set_ease(Tween.EASE_OUT)
	scroll_tween.set_trans(Tween.TRANS_QUAD)
	if not scrollValue > scroll_container.custom_maximum_size.x: scroll_tween.tween_property(scroll_container, "scroll_horizontal", scrollValue, 0.25)
	else: scroll_tween.tween_property(scroll_container, "scroll_horizontal", scroll_container.custom_maximum_size.x, 0.25)
		
	await scroll_tween.finished

func _select_deselect_highlight(dir_next: bool):
	for object in object_container.get_children():
		if object == object_container.get_children()[selected_indx]: 
			object.reverse_anim()
		else: 
			if dir_next: 
				if not object == object_container.get_children()[selected_indx + 1] and not object == object_container.get_children()[selected_indx]: object.play_anim()
			else: 
				if not object == object_container.get_children()[selected_indx - 1] and not object == object_container.get_children()[selected_indx]: object.play_anim()
						

func _on_previous_mouse_entered() -> void: hover.play("hover")
func _on_previous_mouse_exited() -> void: hover.play_backwards("hover")

func _on_next_mouse_entered() -> void: hover_2.play("hover")
func _on_next_mouse_exited() -> void: hover_2.play_backwards("hover")
