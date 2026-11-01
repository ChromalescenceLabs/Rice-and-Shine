extends RichTextLabel
@onready var container: CircularGridContainer = $"../New Selection/Container"
@onready var animation_player: AnimationPlayer = $"../AnimationPlayer"

func _ready() -> void:
	for child in container.get_children():
		child.mouse_entered.connect(changeDesc.bind(child, child.disabled))
		
func changeDesc(button, is_disabled):
	if not is_disabled:
		match button.name.to_lower():
			"rice": set_description("rice description")
			"pancake": set_description("pancake description")
			"hashbrown": set_description("hashbrown description")
			"hotdog": set_description("hotdog description")
			"inihaw": set_description("inihaw description")
			"torta": set_description("torta description")
	elif is_disabled:
		set_description("???")
	
func hide_desc(): animation_player.play_backwards("show_hide")
func show_desc(): animation_player.play("show_hide")
	
	
func set_description(desc_text : String):
	self.text = desc_text

func _on_container_mouse_entered() -> void: show_desc()
func _on_container_mouse_exited() -> void: hide_desc()
