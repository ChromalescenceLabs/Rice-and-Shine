extends Area2D
@onready var bowl_texture: TextureRect = $BowlTexture
@export var ingredient : Texture2D
@export var type : String
var hovering : bool = false
var dragging : bool = false
var in_mixbowl : bool = false
var og_pos : Vector2


func _ready() -> void: 
	bowl_texture.texture = ingredient
	og_pos = self.global_position
	set_process(false)

func _process(_delta: float) -> void:
	if dragging: self.global_position = lerp(self.global_position, get_global_mouse_position(), 0.2)
	

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Click"):
		if hovering: 
			set_process(true)
			dragging = true
	elif event.is_action_released("Click"):
		if hovering: 
			if in_mixbowl:
				match type:
					# For Lumpia Scene
					"GroundPork": get_tree().current_scene.groundpork_added = true
					"MincedOnion": get_tree().current_scene.mincedonion_added = true
					"Carrot": get_tree().current_scene.carrot_added = true
					"Parsley": get_tree().current_scene.parsley_added = true
					# For Pancit Scene
					"SnapPeas": get_tree().current_scene.snappeas_added = true
					"P_Carrot": get_tree().current_scene.carrots_added = true
					"Cabbage": get_tree().current_scene.cabbage_added = true
				get_tree().current_scene.check_mixbowl_contents()
				self.queue_free()
					
			set_process(false)
			dragging = false
			self.global_position = og_pos

func _on_area_entered(area: Area2D) -> void:
	if area is BowlArea: in_mixbowl = true

func _on_area_exited(area: Area2D) -> void:
	if area is BowlArea: in_mixbowl = false


func _on_bowl_texture_mouse_entered() -> void: hovering = true
func _on_bowl_texture_mouse_exited() -> void: hovering = false
