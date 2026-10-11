extends Node2D
signal start_flatten
@onready var flatten_points: Node2D = $FlattenPoints
var flattened_points : int = 0:
	set(value):
		if not value == flattened_points:
			flattened_points = value
			if flattened_points >= 6:
				exit()

@onready var peeled: Sprite2D = $Textures/Peeled
var current_velocity : float = 0
var peelable : bool = false
var mouse_hold : bool = false

func _ready() -> void:
	set_process(false)
	flatten_points.process_mode = Node.PROCESS_MODE_DISABLED

func _process(_delta: float) -> void:
	current_velocity = Input.get_last_mouse_velocity().y
	if current_velocity > 10 and peelable:
		peeled.region_rect.size.y += 0.01 * current_velocity
		if peeled.region_rect.size.y >= 480:
			set_process(false)
			set_process_input(false)
			start_flatten.emit()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			set_process(true)
			if not event.pressed:
				set_process(false)

func _on_hover_texture_mouse_entered() -> void: peelable = true
func _on_hover_texture_mouse_exited() -> void: peelable = false

func exit():
	GlobalVars.successind(get_tree().current_scene)
	await GlobalVars.successIndEnd
	
	GlobalVars.item_exit(self)
	get_tree().current_scene.peelednflattened_torta += 1
	
	await GlobalVars.itemExited
	
	self.queue_free()

func _on_start_flatten() -> void:
	flatten_points.process_mode = Node.PROCESS_MODE_INHERIT
	flatten_points.visible = true
	
