extends Node2D
var dragging : bool = false
var draggable : bool = false 
var pouring : bool = false
var in_bowl : bool = false
var og_pos : Vector2
@onready var sesame_oil_particles: GPUParticles2D = $SesameOilParticles
@onready var sesame_oil_area: Area2D = $SesameOilParticles/SesameOilArea
@onready var texture_rect: TextureRect = $TextureRect


func _ready() -> void:
	og_pos = self.global_position
	
func _process(_delta: float) -> void:
	if dragging: self.global_position = lerp(self.global_position, get_global_mouse_position() + Vector2(-50, -32), 0.2)
	if in_bowl: get_tree().current_scene.oil_progress.value += 1

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Click"):
		if draggable: dragging = true
	elif event.is_action_released("Click"):
		if dragging: 
			pouring = false
			texture_rect.rotation_degrees = 0
			sesame_oil_particles.emitting = false
			sesame_oil_area.monitoring = false
			sesame_oil_area.monitorable = false
			dragging = false
			self.global_position = og_pos
		
	if event.is_action_pressed("Pour"):
		if dragging:
			if pouring:
				pouring = false
				texture_rect.rotation_degrees = 0
				sesame_oil_particles.emitting = false
				sesame_oil_area.monitoring = false
				sesame_oil_area.monitorable = false
			else:
				pouring = true
				texture_rect.rotation_degrees = -47.0
				sesame_oil_particles.emitting = true
				sesame_oil_area.monitoring = true
				sesame_oil_area.monitorable = true

func _on_sesame_oil_area_area_entered(area: Area2D) -> void:
	if area is BowlArea: in_bowl = true
func _on_sesame_oil_area_area_exited(area: Area2D) -> void:
	if area is BowlArea: in_bowl = false


func _on_texture_rect_mouse_entered() -> void: draggable = true
func _on_texture_rect_mouse_exited() -> void: draggable = false


func _on_lumpia_pouring_finished() -> void:
	set_process(false)
