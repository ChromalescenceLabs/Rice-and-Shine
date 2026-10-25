@tool
extends Node2D
@onready var texture_rect: TextureRect = $TextureRect
var hovering := false
var dragging := false
var pouring := false
var og_pos : Vector2
# Change this if the bowl should snap to its original position
var snap_to_og_pos := false
# Call this function, passing the desired og pos in the parameter to set its original position
func set_og_pos(pos : Vector2 = self.global_position): og_pos = pos

@export var texture : Texture2D = preload("uid://cenib63n7hwbs"):
	set(value):
		texture = value
		texture_rect.texture = texture

@export var particles : GPUParticles2D
@export var particles_area : Area2D

func _ready() -> void: texture_rect.texture = texture

func _process(_delta: float) -> void:
	if dragging: 
		self.global_position = lerp(self.global_position, get_global_mouse_position(), 0.2)

func _input(event: InputEvent) -> void:
	if hovering: 
		if event.is_action_pressed("Click"): 
			dragging = true
		elif event.is_action_released("Click"): 
			dragging = false
			if snap_to_og_pos: self.global_position = og_pos
	if dragging:
		if event.is_action_pressed("Pour"): 
			if not pouring:
				particles.emitting = true
				particles_area.monitoring = true
				particles_area.monitorable = true
				self.rotate(-45)
				pouring = true
			else:
				particles.emitting = false
				particles_area.monitoring = false
				particles_area.monitorable = false
				self.rotate(45)
				pouring = false

func _on_texture_rect_mouse_entered() -> void: hovering = true
func _on_texture_rect_mouse_exited() -> void: hovering = false
