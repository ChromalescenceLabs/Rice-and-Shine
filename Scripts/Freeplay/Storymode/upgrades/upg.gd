extends Button
@onready var button: Button = $"."
@onready var desc_cont: Control = $"../DescCont"
@onready var description: RichTextLabel = $"../DescCont/description"

var desc_tween : Tween
var has_been_pressed : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void: 
	text = name


func _on_pressed() -> void:
	if has_been_pressed:
		close_desc()
		return
	
	# Optional: update text here based on button.name if needed
	
	get_parent().opened = true
	var target_height = description.size.y
	description.custom_maximum_size.y = 0
	desc_cont.visible = true
	description.visible = true
	desc_tween = create_tween()
	desc_tween.tween_property(description, "custom_maximum_size:y", target_height, 0.5).set_trans(Tween.TRANS_CUBIC)
	create_tween().tween_property(desc_cont, "custom_minimum_size:y", target_height, 0.5).set_trans(Tween.TRANS_CUBIC)
	
	has_been_pressed = true

func close_desc():
	get_parent().opened = false
	if desc_tween and desc_tween.is_running(): desc_tween.kill()
		
	desc_tween = create_tween()
	desc_tween.tween_property(description, "custom_maximum_size:y", 0, 0.5).set_trans(Tween.TRANS_CUBIC)
	create_tween().tween_property(desc_cont, "custom_minimum_size:y", 0.0, 0.5).set_trans(Tween.TRANS_CUBIC)
	await desc_tween.finished
	description.custom_maximum_size.y = -1.0
	description.visible = false
	desc_cont.visible = false
	has_been_pressed = false
