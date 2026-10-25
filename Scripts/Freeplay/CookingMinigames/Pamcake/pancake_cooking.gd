extends Node2D

@onready var pancake_scene: Node2D = $PancakeScene

@onready var batter_cup: Area2D = $PancakeScene/BatterStuff/BatterCup
@onready var bowl_batter: BatterBowl = $PancakeScene/BatterStuff/BowlBatter
@onready var oil: Area2D = $PancakeScene/Oil
@onready var pan: CookingPan = $PancakeScene/Pan

var hovering_on_pan : bool = false

func _ready() -> void:
	oil.snap_to_og_pos = true
	oil.set_og_pos()
	pancake_scene.position.x += get_viewport().get_visible_rect().size.x
	
	GlobalVars.item_enter(pancake_scene)

func _input(event: InputEvent) -> void:
	if hovering_on_pan:
		if pancState == 3:
			if event.is_action_pressed("Click"):
				if pancCooked < 5:
					pancState = 0
					pancCooked += 1
					pan.unoil()
					
				if pancCooked == 5:
					pancState = 0
					GlobalVars.successind(get_tree().current_scene)
					await GlobalVars.successIndEnd
					
					GlobalVars.item_exit(pancake_scene)
					
					SceneLoader.load_scene("uid://b5ufcgv0qaktk", 1)

func cookTimer():
	await get_tree().create_timer(1.0).timeout
	pancState += 1
		
var pancState : int = 0:
	set(value):
		pancState = value
		if pancState == 0:
			for i in pan.get_children():
				var check : bool = i.owner == pan
				if not check:
					i.visible = false
		elif pancState == 1:
			for i in pan.get_children():
				var check : bool = i.owner == pan
				if not check:
					if not i.name == "PanBatterStage1":	
						i.visible = false
					else:
						i.visible = true
						cookTimer()
		elif pancState == 2:
			for i in pan.get_children():
				var check : bool = i.owner == pan
				if not check:
					if not i.name == "PanBatterStage2":
						i.visible = false
					else:
						i.visible = true
						cookTimer()
		elif pancState == 3:
			for i in pan.get_children():
				var check : bool = i.owner == pan
				if not check:
					if not i.name == "PanBatterStage3":
						i.visible = false
					else:
						i.visible = true

var pancCooked : int = 0

func _on_pan_mouse_entered() -> void: hovering_on_pan = true
func _on_pan_mouse_exited() -> void: hovering_on_pan = false
