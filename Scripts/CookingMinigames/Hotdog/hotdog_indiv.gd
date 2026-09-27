extends Area2D
class_name Hotdog

@onready var raw_unchopped: Sprite2D = $RawUnchopped
@onready var raw_1: Sprite2D = $Raw1
@onready var raw_2: Sprite2D = $Raw2
@onready var raw_3: Sprite2D = $Raw3
@onready var cooked: TextureRect = $Cooked

var dragging: bool = false
var in_pan: bool = false
var og_pos: Vector2

var pan

func _ready() -> void:
	og_pos = position
	set_process_input(false)
	cooked.modulate.a = 0
	
func _process(_delta: float) -> void:
	if dragging: self.global_position = lerp(self.global_position, get_global_mouse_position(), 0.2)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Click"):
		dragging = true
	elif event.is_action_released("Click"):
		dragging = false
		pan = get_tree().current_scene.hdog_pan
		if in_pan and pan.has_hdog == false and pan.has_oil == true:
			pan.has_hdog = true
			self.position = pan.position
			self.monitoring = false
			self.monitorable = false
			cooked.mouse_filter = Control.MOUSE_FILTER_IGNORE
			cook()
			pan.unoil()
		else:
			self.position = og_pos

func _on_cooked_mouse_entered() -> void: set_process_input(true)
func _on_cooked_mouse_exited() -> void: set_process_input(false)

func _on_area_entered(area: Area2D) -> void:
	if area is HdogPan:
		in_pan = true

func _on_area_exited(area: Area2D) -> void:
	if area is HdogPan:
		in_pan = false

func cook() -> void:
	var tw = create_tween().tween_property(cooked, "modulate:a", 1, 1)
	await tw.finished
	
	GlobalVars.successind(get_tree().current_scene)
	await GlobalVars.successIndEnd
	
	GlobalVars.item_exit(self)
	get_tree().current_scene.frying_hotdog_no -= 1
	if get_tree().current_scene.frying_hotdog_no <= 0: get_tree().current_scene.frying_finished.emit()
	pan.has_hdog = false
	
	await GlobalVars.itemExited
	self.queue_free()
