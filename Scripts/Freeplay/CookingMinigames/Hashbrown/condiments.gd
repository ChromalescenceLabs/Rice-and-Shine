extends Node2D
const BORDER = preload("uid://bqevegjdxbpb6")
@onready var bowl: Area2D = $"../Bowl"

var particle
var curObject

func _ready() -> void:
	for child in get_children():
		if child is Area2D:
			child.mouse_entered.connect(toggleHighlight.bind(true, child))
			child.mouse_exited.connect(toggleHighlight.bind(false, child))
			child.input_event.connect(input.bind(child))

func toggleHighlight(state:bool, area):
	for c in area.get_children():
		if c is Sprite2D or c is AnimatedSprite2D or c is TextureRect:
			if state==true:
				c.material = ShaderMaterial.new()
				c.material.shader = BORDER
			else:
				c.material = null

func input(_viewport: Node, event: InputEvent, _shape_idx: int, area: Area2D):
	if area.name !="cheese":
		if event.is_action_pressed("Click"):
			area.set_process(true)
			area.hold=true
			area.rotation_degrees=30
			particle=area.find_child("CPUParticles2D")
			particle.emitting=true
		if event.is_action_released("Click"):
			area.hold=false
			area.rotation_degrees=0
			particle.emitting=false

func _on_bowl_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed("Click"):
		find_child("cheese").get_child(0).visible=false
		find_child("cheese").get_child(1).visible=true
