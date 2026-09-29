extends Node2D

@onready var pancake_scene: Node2D = $PancakeScene

@onready var batter_cup: Area2D = $PancakeScene/BatterStuff/BatterCup
@onready var bowl_batter: BatterBowl = $PancakeScene/BatterStuff/BowlBatter
@onready var pan: PancakePan = $PancakeScene/Pan
@onready var oil: Area2D = $PancakeScene/Oil

func _ready() -> void:
	pancake_scene.position.x += get_viewport().get_visible_rect().size.x
	GlobalVars.item_enter(pancake_scene)
