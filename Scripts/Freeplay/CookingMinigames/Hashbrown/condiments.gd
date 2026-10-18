extends Node2D
const BORDER = preload("uid://bqevegjdxbpb6")

var condiments=[]

func _ready() -> void:
# myChild is the parent scene so change that to whatever scene needs this
	for child in get_children():
		if child is Area2D:
			child.mouse_entered.connect(toggleHighlight.bind(true, child))
			child.mouse_exited.connect(toggleHighlight.bind(false, child))


func toggleHighlight(state:bool, area):
	for c in area.get_children():
		if c is Sprite2D or c is AnimatedSprite2D or c is TextureRect:
			if state==true:
				c.material = ShaderMaterial.new()
				c.material.shader = BORDER
			else:
				c.material = null
