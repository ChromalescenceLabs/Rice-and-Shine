extends Control

# basic button anim variables
@export var tween_intensity: float
@export var tween_duration : float

@onready var text: Panel = $TEXT
@onready var ch_1btn: Button = $BTNS/CH1BTN
@onready var ch_2btn: Button = $BTNS/CH2BTN
@onready var ch_3btn: Button = $BTNS/CH3BTN

#carousel menu variables.. holy moley. 
#wouldnt have been able to do this stupid thing without youtube at all, like wtf??
#before i got into godot, i thought coding my ideas would be okay nothing hard but now?? 
#now that i have to do my own ideas?? lets hold hands and toes together and cry 

@export var spacing: float = 20.0

@export var wraparound_enabled: bool = false 
@export var wraparound_radius: float = 30.0
@export var wraparound_height: float = 50.0

@export_range(0.0,1.0) var opacity_strength: float = 0.35
@export_range(0.0,1.0) var scale_length: float = 0.25
@export_range(0.01 ,0.99, 0.01) var scale_min: float = 0.1

@export var smoothing_speed: float = 6.5
@export var selected_index: int = 0
@export var follow_button_focus: bool = false

@export var position_offset_node: Control = null 

#makes it so that panel doesnt show immediately
func _ready() -> void:
	text.visible = false

	btn_hovered(ch_1btn)
	btn_hovered(ch_2btn)
	btn_hovered(ch_3btn)

#for carousel menu, remmeber to explain how this works later
func _process(delta:float) -> void:
	if !position_offset_node or position_offset_node.get_child_count() == 0:
		return
	
	selected_index = clamp( selected_index, 0, position_offset_node.get_child_count()-1)
	
	for i in position_offset_node.get_children():
		if wraparound_enabled:
			var max_index_range = max(1, (position_offset_node.get_child_count()-1)/2.0)
			var angle = clamp(i.get_index() - selected_index / max_index_range, -1.0, 1.0) * PI
			var x = sin(angle) * wraparound_radius
			var y = cos(angle) * wraparound_height
			var target_pos = Vector2(x, y-wraparound_height) - i.size/2.0
			i.position = lerp(i.position, target_pos, smoothing_speed * delta)
		else:
			var position_x = 0
			if i. get_index() > 0:
				position_x = position_offset_node.get_child(i.get_index()-1).position.x + position_offset_node.get_child(i.get_index()-1).size.x + spacing
			i.position = Vector2(position_x, -i.size.y / 2.0)
	
	if wraparound_enabled:
		position_offset_node.position.x = lerp( position_offset_node.x, 0.0, smoothing_speed * delta)
	else:
		position_offset_node.position.x = lerp( position_offset_node.x, -(position_offset_node.get_child(selected_index).position.x + position_offset_node.get_child(selected_index).size.x/2.0, smoothing_speed * delta)

#button hover animations
func start_tween(object: Object, property: String, final_val: Variant, duration: float):
	var tween = create_tween()
	tween.tween_property(object, property,final_val, duration)

func btn_hovered(button: Button):
	button.pivot_offset = button.size / 2
	if button.is_hovered():
		start_tween(button, "scale", Vector2.ONE * tween_intensity, tween_duration)
	else:
		start_tween(button, "scale", Vector2.ONE, tween_duration)

#script so that panel "TEXT" pops up
func _on_ch_1btn_mouse_entered() -> void:
	text.visible = true 

func _on_ch_1btn_mouse_exited() -> void:
	text.visible = false # Replace with function body.

func _on_ch_2btn_mouse_entered() -> void:
	text.visible = true # Replace with function body.

func _on_ch_2btn_mouse_exited() -> void:
	text.visible = false

func _on_ch_3btn_mouse_entered() -> void:
	text.visible = true

func _on_ch_3btn_mouse_exited() -> void:
	text.visible = false
