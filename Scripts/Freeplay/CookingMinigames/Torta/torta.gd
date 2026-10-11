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

#PEEL & FLATTEN
signal tortapeelnflatten_finished
const EGGPLANT_PEEL = preload("uid://xy6lg1ajeyia")
@onready var plate: Sprite2D = $PeelAndFlatten/Plate
var peelednflattened_torta: int = 0:
	set(value):
		if not peelednflattened_torta == value:
			peelednflattened_torta = value
			if peelednflattened_torta >= 3:
				tortapeelnflatten_finished.emit()
			else:
				var eggpl_peel = EGGPLANT_PEEL.instantiate()
				eggpl_peel.global_position = plate.global_position
				eggpl_peel.global_position.x += get_viewport().get_visible_rect().size.x
				peel_and_flatten.add_child(eggpl_peel)
				create_tween().tween_property(eggpl_peel, "position", plate.global_position, 1.5).set_trans(Tween.TRANS_ELASTIC)

func _ready() -> void:
	grill.position.x += get_viewport().get_visible_rect().size.x
	peel_and_flatten.position.x += get_viewport().get_visible_rect().size.x
	egg_crack.position.x += get_viewport().get_visible_rect().size.x
	egg_mix.position.x += get_viewport().get_visible_rect().size.x
	coating.position.x += get_viewport().get_visible_rect().size.x
	cook.position.x += get_viewport().get_visible_rect().size.x
	
	#GlobalVars.item_enter(grill)
	GlobalVars.item_enter(peel_and_flatten)
	
func _on_tortagrill_finished() -> void:
	GlobalVars.item_exit(grill)
	GlobalVars.item_enter(peel_and_flatten)

func _on_tortapeelnflatten_finished() -> void:
	GlobalVars.item_exit(peel_and_flatten)
	GlobalVars.item_enter(egg_crack)
