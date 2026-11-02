extends Node2D
const BORDER = preload("uid://b7cg3ikv2m2w7")
@onready var bowl: Area2D = $"../Bowl"
@onready var potato: Area2D = $"../potato"
@onready var mix: Node2D = $"../mix"

var particle
var curObject
var done=0
var canPut=false

func _ready() -> void:
	mix.position.x += get_viewport().get_visible_rect().size.x
	for child in get_children():
		if child is Area2D:
			child.input_event.connect(input.bind(child))
			
			# Apply the border shader to its internal sprites immediately
			for c in child.get_children():
				if c is Sprite2D or c is AnimatedSprite2D or c is TextureRect:
					c.material = ShaderMaterial.new()
					c.material.shader = BORDER

func input(_viewport: Node, event: InputEvent, _shape_idx: int, area: Area2D):
	if done != 5 and not potato.hold:
		if area.name !="cheese" and not potato.visible:
			var origIndex =area.get_index()
			if event.is_action_pressed("Click"):
				move_child(area,-1)
				curObject=area
				area.set_process(true)
				area.hold=true
				area.rotation_degrees=30
				particle=area.find_child("CPUParticles2D")
				particle.emitting=true
			if event.is_action_released("Click"):
				move_child(area,origIndex)
				area.hold=false
				area.rotation_degrees=0
				particle.emitting=false
				if not bowl.find_child(area.name.to_lower()).visible and canPut:
					done+=1
					bowl.find_child(area.name.to_lower()).visible=true
					for c in area.get_children():
						if c is Sprite2D or c is AnimatedSprite2D or c is TextureRect:
							c.material = ShaderMaterial.new()
							c.material.shader = null
					if done == 5:
						print("done")
						next()

		else:
			if event.is_action_pressed("Click") and not bowl.find_child("cheese").visible:
				curObject=area
				area.get_child(0).visible=false
				area.get_child(1).visible=true
				potato.visible=true
				potato.set_process(true)
				potato.hold=true

func _on_potato_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_released("Click"):
		if potato.areaEnter:
			if potato.areaEnter.name=="Bowl":
				var cheese = bowl.find_child("cheese")
				potato.visible=false
				if not cheese.visible and canPut:
					cheese.visible=true
					done +=1
					for c in curObject.get_children():
						if c is Sprite2D or c is AnimatedSprite2D or c is TextureRect:
							c.material = ShaderMaterial.new()
							c.material.shader = null
					if done == 5:
						print("done")
						next()
		else:
			curObject.get_child(0).visible=true
			curObject.get_child(1).visible=false
			potato.hold=false
			potato.visible=false

func next():
	for child in get_children():
		child.set_process(false)
	potato.set_process_input(false)
	GlobalVars.item_exit(self)
	GlobalVars.item_enter(mix)

func _on_bowl_mouse_entered() -> void:
	canPut=true

func _on_bowl_mouse_exited() -> void:
	canPut=false
