extends Area2D
@onready var pre_cook: TextureRect = $PreCook
@onready var cooked: TextureRect = $Cooked

var dragging: bool = false
var in_pan: bool = false
var og_pos: Vector2
var hovering: bool = false

var pan

func _ready() -> void:
	og_pos = position
	set_process_input(false)
	cooked.modulate.a = 0
	
func _process(_delta: float) -> void:
	if dragging: self.global_position = lerp(self.global_position, get_global_mouse_position(), 0.2)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Click"):
		if hovering: dragging = true
	elif event.is_action_released("Click"):
		if hovering:
			dragging = false
			pan = get_tree().current_scene.torta_pan
			if in_pan and pan.has_obj == false and pan.has_oil == true:
				pan.has_obj = true
				self.position = pan.position
				self.monitoring = false
				self.monitorable = false
				cooked.mouse_filter = Control.MOUSE_FILTER_IGNORE
				cook()
				pan.unoil()
			else:
				self.position = og_pos

func _on_cooked_mouse_entered() -> void: 
	hovering = true
	set_process_input(true)
func _on_cooked_mouse_exited() -> void: 
	hovering = false
	set_process_input(false)

func _on_area_entered(area: Area2D) -> void:
	if area is TortaPan:
		in_pan = true

func _on_area_exited(area: Area2D) -> void:
	if area is TortaPan:
		in_pan = false

func cook() -> void:
	var tw = create_tween().tween_property(cooked, "modulate:a", 1, 1)
	await tw.finished
	
	GlobalVars.successind(get_tree().current_scene)
	await GlobalVars.successIndEnd
	
	GlobalVars.item_exit(self)
	get_tree().current_scene.uncooked_eggplants -= 1
	if get_tree().current_scene.uncooked_eggplants <= 0: get_tree().current_scene.torta_frying_finished.emit()
	pan.has_obj = false
	
	await GlobalVars.itemExited
	self.queue_free()
