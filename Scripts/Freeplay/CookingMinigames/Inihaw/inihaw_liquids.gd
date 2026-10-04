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
	if pouring: 
		if Input.is_action_just_pressed("Pour"): 
			pouring = false
			match liq_type:
				"Soy": soy_sauce.rotation = 0
				"Calamansi": calamansi.rotation = 0
				"Ketchup": ketchup.rotation = 0
				"Sprite": sprite.rotation = 0
			
			set_process_input(true)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Click"):
		if draggable: dragging = true
	elif event.is_action_released("Click"):
		if dragging: dragging = false
	elif event.is_action_pressed("Pour"):
		if dragging:
			match liq_type:
				"Soy": soy_sauce.rotation = -180
				"Calamansi": calamansi.rotation = -90
				"Ketchup": ketchup.rotation = -90
				"Sprite": sprite.rotation = -90
			
			set_process_input(false)
			pouring = true

func check_liquid(liquid_type: String):
	print(liquid_type)
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
