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

# EGG CRACK 
signal egg_crack_finished
@onready var egg_carton: TextureRect = $EggCrack/EggCarton
@onready var eggcrack_bowl: BowlArea = $EggCrack/Bowl
var cracked_egg_amt: int = 0:
	set(value):
		if not cracked_egg_amt == value:
			cracked_egg_amt = value
			if cracked_egg_amt >= 2:
				egg_crack_finished.emit()

# EGG MIX
signal egg_mix_finished

# EGG COAT
signal eggcoat_start
signal eggcoat_finished
var uncoated_torta: int = 3:
	set(value):
		if not uncoated_torta == value:
			uncoated_torta = value
			if uncoated_torta <= 0:
				eggcoat_finished.emit()

# COOK
signal torta_frying_finished
@onready var oil: Area2D = $Cook/Oil
@onready var torta_pan: TortaPan = $Cook/TortaPan
var uncooked_eggplants: int = 3

func _ready() -> void:
	oil.monitoring = false
	grill.position.x += get_viewport().get_visible_rect().size.x
	peel_and_flatten.position.x += get_viewport().get_visible_rect().size.x
	egg_crack.position.x += get_viewport().get_visible_rect().size.x
	egg_mix.position.x += get_viewport().get_visible_rect().size.x
	coating.position.x += get_viewport().get_visible_rect().size.x
	cook.position.x += get_viewport().get_visible_rect().size.x
	
	GlobalVars.item_enter(grill)
	
func _on_tortagrill_finished() -> void:
	GlobalVars.item_exit(grill)
	GlobalVars.item_enter(peel_and_flatten)

func _on_tortapeelnflatten_finished() -> void:
	GlobalVars.item_exit(peel_and_flatten)
	GlobalVars.item_enter(egg_crack)
	
	create_tween().tween_property(top_down_bg, "modulate:a", 0, 0.3).set_trans(Tween.TRANS_CUBIC)

func _on_egg_crack_finished() -> void:
	egg_carton.mouse_filter = Control.MOUSE_FILTER_IGNORE
	GlobalVars.successind(get_tree().current_scene)
	await GlobalVars.successIndEnd
	
	GlobalVars.item_exit(egg_crack)
	GlobalVars.item_enter(egg_mix)

	create_tween().tween_property(top_down_bg, "modulate:a", 1, 0.3).set_trans(Tween.TRANS_CUBIC)
	
func _on_egg_mix_finished() -> void:
	GlobalVars.successind(get_tree().current_scene)
	await GlobalVars.successIndEnd
	
	GlobalVars.item_exit(egg_mix)
	GlobalVars.item_enter(coating)
	
	await GlobalVars.itemEntered
	
	eggcoat_start.emit()


func _on_eggcoat_finished() -> void:
	GlobalVars.successind(get_tree().current_scene)
	await GlobalVars.successIndEnd
	
	GlobalVars.item_exit(coating)
	GlobalVars.item_enter(cook)
	
	await GlobalVars.itemEntered
	oil.monitoring = true


func _on_torta_frying_finished() -> void:
	GlobalVars.item_exit(cook)
	SceneLoader.load_scene("uid://b5ufcgv0qaktk", 1)
