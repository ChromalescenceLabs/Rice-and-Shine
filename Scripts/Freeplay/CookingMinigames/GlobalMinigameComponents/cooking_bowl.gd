extends Control
@onready var cooking_bowl_texture: TextureRect = $CookingBowlTexture

var hovering := false
var dragging := false
var og_pos : Vector2
# Change this if the bowl should snap to its original position
var snap_to_og_pos := false
# Change this if the bowl's texture needs any changing
@export var bowl_texture : Texture2D = preload("res://Assets/Freeplay/Serving/ServeBowl.png")
# Call this function, passing the desired og pos in the parameter to set its original position
func set_og_pos(pos : Vector2 = self.global_position): og_pos = pos

func _ready() -> void:
	cooking_bowl_texture.texture = bowl_texture

func _process(_delta: float) -> void:
	if dragging: self.global_position = lerp(self.global_position, get_global_mouse_position(), 0.2)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Click"): 
		if hovering: dragging = true
	elif event.is_action_released("Click"): 
		if hovering: 
			dragging = false
			if snap_to_og_pos:
				self.global_position = og_pos

func _on_cooking_bowl_texture_mouse_entered() -> void: hovering = true
func _on_cooking_bowl_texture_mouse_exited() -> void: hovering = false
