extends Node2D
const BORDER = preload("uid://bqevegjdxbpb6")
@onready var bowl: Area2D = $"../Bowl"
@onready var potato: Area2D = $"../potato"

var particle
var curObject
var done=0

func _ready() -> void:
	for child in get_children():
		if child is Area2D:
			child.input_event.connect(input.bind(child))

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
			if not bowl.find_child(area.name.to_lower()).visible:
				done+=1
				bowl.find_child(area.name.to_lower()).visible=true
				print(done)
				if done == 5:
					print("done")
					GlobalVars.item_exit(self)

	else:
		curObject=area
		if event.is_action_pressed("Click") and not bowl.find_child("cheese").visible:
			area.get_child(0).visible=false
			area.get_child(1).visible=true
			potato.visible=true
			potato.set_process(true)
			potato.hold=true

func _on_potato_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_released("Click"):
		if potato.areaEnter:
			if potato.areaEnter.name=="Bowl":
				potato.visible=false
				if not bowl.find_child("cheese").visible:
					bowl.find_child("cheese").visible=true
					done +=1
					print(done)
					if done == 5:
						print("done")
						GlobalVars.item_exit(self)

		else:
			curObject.get_child(0).visible=true
			curObject.get_child(1).visible=false
			potato.hold=false
			potato.visible=false
				
