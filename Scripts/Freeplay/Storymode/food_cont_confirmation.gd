extends Panel
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var food_conf_box: Panel = $".."
@onready var food_conts: HBoxContainer = $"../../../Control/ScrollContainer/FoodConts"
var associate_node : TextureButton

func _ready() -> void: 
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	food_conf_box.mouse_filter = Control.MOUSE_FILTER_IGNORE

func enter(node : TextureButton): 
	associate_node = node
	animation_player.play("Enter")
	food_conf_box.mouse_filter = Control.MOUSE_FILTER_STOP
	await animation_player.animation_finished
	
	
	mouse_filter = Control.MOUSE_FILTER_PASS
	
func _on_yes_pressed() -> void:
	for i in food_conts.get_children():
		if i == associate_node:
			i.confirmation.emit(true)


func _on_no_pressed() -> void:
	animation_player.play_backwards("Enter")
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	food_conf_box.mouse_filter = Control.MOUSE_FILTER_IGNORE
	
	for i in food_conts.get_children():
		if i == associate_node:
			i.confirmation.emit(false)
