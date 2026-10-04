extends Node2D
@onready var soy_sauce: TextureRect = $Sprites/SoySauce
@onready var calamansi: TextureRect = $Sprites/Calamansi
@onready var ketchup: TextureRect = $Sprites/Ketchup
@onready var sprite: TextureRect = $Sprites/Sprite

@onready var soyParticles: GPUParticles2D = $Particles/Soy
@onready var calamansiParticles: GPUParticles2D = $Particles/Calamnsi
@onready var ketchupParticles: GPUParticles2D = $Particles/Ketchup
@onready var spriteParticles: GPUParticles2D = $Particles/Sprite

var liq_type : String
var draggable : bool = false
var dragging : bool = false
var pouring : bool = false

func _process(_delta: float) -> void:
	if dragging: self.global_position = lerp(self.global_position, get_global_mouse_position() + Vector2(-50, -32), 0.2)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Click"):
		if draggable: dragging = true
	elif event.is_action_released("Click"):
		if dragging: dragging = false
		
	if event.is_action_pressed("Pour"):
		if dragging:
			if pouring:
				pouring = false
				match liq_type:
					"Soy": 
						soy_sauce.rotation = 0
						soyParticles.emitting = false
					"Calamansi": 
						calamansi.rotation = 0
						calamansiParticles.emitting = false
					"Ketchup": 
						ketchup.rotation = 0
						ketchupParticles.emitting = false
					"Sprite": 
						sprite.rotation = 0
						sprite.emitting = false
			else:
				match liq_type:
					"Soy": 
						soy_sauce.rotation = 180
						soyParticles.emitting = true
					"Calamansi": 
						calamansi.rotation = -90
						calamansiParticles.emitting = true
					"Ketchup": 
						ketchup.rotation = -90
						ketchupParticles.emitting = true
					"Sprite": 
						sprite.rotation = -90
						spriteParticles.emitting = true
					
				pouring = true

func check_liquid(liquid_type: String):
	liq_type = liquid_type
	match liquid_type:
		"Soy":
			soy_sauce.visible = true
		"Calamansi":
			calamansi.visible = true
		"Ketchup":
			ketchup.visible = true
		"Sprite":
			sprite.visible = true

func _on_soy_sauce_mouse_entered() -> void: draggable = true
func _on_soy_sauce_mouse_exited() -> void: draggable = false

func _on_calamansi_mouse_entered() -> void: draggable = true
func _on_calamansi_mouse_exited() -> void: draggable = false

func _on_ketchup_mouse_entered() -> void: draggable = true
func _on_ketchup_mouse_exited() -> void: draggable = false

func _on_sprite_mouse_entered() -> void: draggable = true
func _on_sprite_mouse_exited() -> void: draggable = false
