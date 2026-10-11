extends Area2D
@onready var coated: TextureRect = $Coated

var dragging: bool = false
var hovering: bool = false
var og_pos: Vector2

func _ready() -> void:
	og_pos = self.global_position
	self.monitoring = false
	
	get_tree().current_scene.eggcoat_start.connect(_on_torta_eggcoat_start)
	get_tree().current_scene.eggcoat_finished.connect(_on_torta_eggcoat_finished)

func _process(_delta: float) -> void:
	if dragging: self.global_position = lerp(self.global_position, get_global_mouse_position(), 0.2)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Click"):
		if hovering: dragging = true
	elif event.is_action_released("Click"):
		if hovering:
			dragging = false
			self.global_position = og_pos

func _on_area_entered(area: Area2D) -> void:
	if area is BowlArea: 
		coated.modulate.a = 1
		get_tree().current_scene.uncoated_torta -= 1

func _on_coated_mouse_entered() -> void: 
	hovering = true
	set_process_input(true)
func _on_coated_mouse_exited() -> void: 
	hovering = false
	set_process_input(false)

func _on_torta_eggcoat_start() -> void:
	self.monitoring = true

func _on_torta_eggcoat_finished() -> void:
	self.set_deferred("monitoring", false)
