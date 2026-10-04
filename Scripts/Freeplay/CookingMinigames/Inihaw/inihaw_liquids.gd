extends Node2D

@onready var soy_sauce: TextureRect = $Sprites/SoySauce
@onready var calamansi: TextureRect = $Sprites/Calamansi
@onready var ketchup: TextureRect = $Sprites/Ketchup
@onready var sprite: TextureRect = $Sprites/Sprite

@onready var soyParticles: GPUParticles2D = $Particles/Soy
@onready var calamansiParticles: GPUParticles2D = $Particles/Calamnsi
@onready var ketchupParticles: GPUParticles2D = $Particles/Ketchup
@onready var spriteParticles: GPUParticles2D = $Particles/Sprite

@onready var soy_area: Area2D = $Particles/Soy/SoyArea
@onready var calamansi_area: Area2D = $Particles/Calamnsi/CalamansiArea
@onready var ketchup_area: Area2D = $Particles/Ketchup/KetchupArea
@onready var sprite_area: Area2D = $Particles/Sprite/SpriteArea

var liq_type : String
var draggable : bool = false
var dragging : bool = false
var pouring : bool = false

var in_soy: bool = false
var in_cal: bool = false
var in_ketchup: bool = false
var in_sprite: bool = false

func _process(_delta: float) -> void:
	if dragging: self.global_position = lerp(self.global_position, get_global_mouse_position() + Vector2(-50, -32), 0.2)
	if in_soy: get_tree().current_scene.progress_bars.soy_sauce_bar.value += 1
	if in_cal: get_tree().current_scene.progress_bars.calamansi_bar.value += 1
	if in_ketchup: get_tree().current_scene.progress_bars.ketchup_bar.value += 1
	if in_sprite: get_tree().current_scene.progress_bars.sprite_bar.value += 1

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
						soy_area.monitoring = false
						soy_area.monitorable = false
					"Calamansi": 
						calamansi.rotation = 0
						calamansiParticles.emitting = false
						calamansi_area.monitoring = false
						calamansi_area.monitorable = false
					"Ketchup": 
						ketchup.rotation = 0
						ketchupParticles.emitting = false
						ketchup_area.monitoring = false
						ketchup_area.monitorable = false
					"Sprite": 
						sprite.rotation = 0
						sprite.emitting = false
						sprite_area.monitoring = false
						sprite_area.monitorable = false
			else:
				match liq_type:
					"Soy": 
						soy_sauce.rotation = 180
						soyParticles.emitting = true
						soy_area.monitoring = true
						soy_area.monitorable = true
					"Calamansi": 
						calamansi.rotation = -90
						calamansiParticles.emitting = true
						calamansi_area.monitoring = true
						calamansi_area.monitorable = true
					"Ketchup": 
						ketchup.rotation = -90
						ketchupParticles.emitting = true
						ketchup_area.monitoring = true
						ketchup_area.monitorable = true
					"Sprite": 
						sprite.rotation = -90
						spriteParticles.emitting = true
						sprite_area.monitoring = true
						sprite_area.monitorable = true
					
				pouring = true

func check_liquid(liquid_type: String):
	liq_type = liquid_type
	match liquid_type:
		"Soy":
			soy_sauce.visible = true
			calamansi.visible = false
			ketchup.visible = false
			sprite.visible = false
		"Calamansi":
			soy_sauce.visible = false
			calamansi.visible = true
			ketchup.visible = false
			sprite.visible = false
		"Ketchup":
			soy_sauce.visible = false
			calamansi.visible = false
			ketchup.visible = true
			sprite.visible = false
		"Sprite":
			soy_sauce.visible = false
			calamansi.visible = false
			ketchup.visible = false
			sprite.visible = true

func _on_soy_sauce_mouse_entered() -> void: draggable = true
func _on_soy_sauce_mouse_exited() -> void: draggable = false

func _on_calamansi_mouse_entered() -> void: draggable = true
func _on_calamansi_mouse_exited() -> void: draggable = false

func _on_ketchup_mouse_entered() -> void: draggable = true
func _on_ketchup_mouse_exited() -> void: draggable = false

func _on_sprite_mouse_entered() -> void: draggable = true
func _on_sprite_mouse_exited() -> void: draggable = false



func _on_soy_area_area_entered(area: Area2D) -> void: if area is BowlFillArea: in_soy = true
func _on_soy_area_area_exited(area: Area2D) -> void: if area is BowlFillArea: in_soy = false

func _on_calamansi_area_area_entered(area: Area2D) -> void: if area is BowlFillArea: in_cal = true
func _on_calamansi_area_area_exited(area: Area2D) -> void: if area is BowlFillArea: in_cal = false 

func _on_ketchup_area_area_entered(area: Area2D) -> void: if area is BowlFillArea: in_ketchup = true
func _on_ketchup_area_area_exited(area: Area2D) -> void: if area is BowlFillArea: in_ketchup = false

func _on_sprite_area_area_entered(area: Area2D) -> void: if area is BowlFillArea: in_sprite = true
func _on_sprite_area_area_exited(area: Area2D) -> void: if area is BowlFillArea: in_sprite = false
