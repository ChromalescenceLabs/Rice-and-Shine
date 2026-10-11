extends Node2D
@onready var top_down_bg: Sprite2D = $TopDownBG
@onready var front_bg: Sprite2D = $FrontBG

@onready var grill: Node2D = $Grill
@onready var peel_and_flatten: Node2D = $PeelAndFlatten
@onready var egg_crack: Node2D = $EggCrack
@onready var egg_mix: Node2D = $EggMix
@onready var coating: Node2D = $Coating
@onready var cook: Node2D = $Cook

# GRILL
signal tortagrill_finished
@onready var grill_torta_pan: Area2D = $Grill/TortaPan
var uncooked_torta: int = 3


func _ready() -> void:
	grill.position.x += get_viewport().get_visible_rect().size.x
	peel_and_flatten.position.x += get_viewport().get_visible_rect().size.x
	egg_crack.position.x += get_viewport().get_visible_rect().size.x
	egg_mix.position.x += get_viewport().get_visible_rect().size.x
	coating.position.x += get_viewport().get_visible_rect().size.x
	cook.position.x += get_viewport().get_visible_rect().size.x
	
	GlobalVars.item_enter(grill)
	

func _on_tortagrill_finished() -> void:
	GlobalVars.item_exit(grill)
