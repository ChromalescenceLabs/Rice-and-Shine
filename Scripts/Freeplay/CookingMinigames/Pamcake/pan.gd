extends Area2D
class_name PancakePan

@onready var pancake_scene: Node2D = $".."

@onready var pan_empty: Sprite2D = $Pan
@onready var pan_oiled: Sprite2D = $PanOil
@onready var pan_batter_s1: Sprite2D = $PanBatterStage1
@onready var pan_batter_s2: Sprite2D = $PanBatterStage2
@onready var pan_batter_s3: Sprite2D = $PanBatterStage3

var has_oil : bool = false
var pancCooked : int = 0
	

func oiled() -> void:
	if has_oil == true:
		pan_oiled.visible = true
		pan_empty.visible = false
		

func cookTimer():
	await get_tree().create_timer(3.0).timeout
	pancState += 1
		
var pancState : int = 0:
	set(value):
		pancState = value
		if pancState == 0:
			for i in self.get_children():
				if not i.name == "Pan":	
					i.visible = false
				else:
					i.visible = true
		elif pancState == 1:
			for i in self.get_children():
				if not i.name == "PanBatterStage1":	
					i.visible = false
				else:
					i.visible = true
					cookTimer()
		elif pancState == 2:
			for i in self.get_children():
				if not i.name == "PanBatterStage2":
					i.visible = false
				else:
					i.visible = true
					cookTimer()
		elif pancState == 3:
			for i in self.get_children():
				if not i.name == "PanBatterStage3":
					i.visible = false
				else:
					i.visible = true

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if pancState == 3:
		if event.is_action_pressed("Click"):
			if pancCooked < 5:
				pancState = 0
				pancCooked += 1
				
			if pancCooked == 5:
				pancState = 0
				GlobalVars.successind(get_parent())
				await GlobalVars.successIndEnd
				
				GlobalVars.item_exit(pancake_scene)
				
				SceneLoader.load_scene("uid://b5ufcgv0qaktk", 1)
