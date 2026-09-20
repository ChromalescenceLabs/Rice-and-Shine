extends Area2D
class_name PancakePan

@onready var pan_empty: Sprite2D = $Pan
@onready var pan_oiled: Sprite2D = $PanOil
@onready var pan_batter_s1: Sprite2D = $PanBatterStage1
@onready var pan_batter_s2: Sprite2D = $PanBatterStage2
@onready var pan_batter_s3: Sprite2D = $PanBatterStage3

var has_oil : bool = false

func oiled() -> void:
	if has_oil == true:
		pan_oiled.visible = true
		pan_empty.visible = false
		

func cookTimer():
	await get_tree().create_timer(5.0).timeout
	pancState += 1
	
var pancState : int = 0:
	set(value):
		pancState = value
		if pancState == 1:
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
