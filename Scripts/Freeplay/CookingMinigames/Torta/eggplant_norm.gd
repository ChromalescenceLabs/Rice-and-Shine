extends Area2D
var pan

@onready var eggplant_cooked_texture: TextureRect = $EggplantCookedTexture
@onready var eggplant_normal_texture: TextureRect = $EggplantNormalTexture

var dragging: bool = false
var in_pan: bool = false
var og_pos: Vector2

func _ready() -> void:
	og_pos = position
	set_process_input(false)
	eggplant_cooked_texture.modulate.a = 0
	
func _process(_delta: float) -> void:
	if dragging: self.global_position = lerp(self.global_position, get_global_mouse_position(), 0.2)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Click"):
		dragging = true
	elif event.is_action_released("Click"):
		dragging = false
		pan = get_tree().current_scene.grill_torta_pan
		if in_pan and not pan.has_obj:
			pan.has_obj = true
			self.global_position = pan.global_position
			self.monitoring = false
			self.monitorable = false
			eggplant_normal_texture.mouse_filter = Control.MOUSE_FILTER_IGNORE
			cook()
		else:
			self.position = og_pos
		
func _on_area_entered(area: Area2D) -> void:
	if area is Pan: in_pan = true

func _on_area_exited(area: Area2D) -> void:
	if area is Pan: in_pan = false

func cook() -> void:
	var tw = create_tween().tween_property(eggplant_cooked_texture, "modulate:a", 1, 1)
	await tw.finished
	
	GlobalVars.successind(get_tree().current_scene)
	await GlobalVars.successIndEnd
	
	GlobalVars.item_exit(self)
	get_tree().current_scene.uncooked_torta -= 1
	if get_tree().current_scene.uncooked_torta <= 0: get_tree().current_scene.tortagrill_finished.emit()
	pan.has_obj = false
	
	await GlobalVars.itemExited
	self.queue_free()


func _on_eggplant_cooked_texture_mouse_entered() -> void: set_process_input(true)
func _on_eggplant_cooked_texture_mouse_exited() -> void: set_process_input(false)
