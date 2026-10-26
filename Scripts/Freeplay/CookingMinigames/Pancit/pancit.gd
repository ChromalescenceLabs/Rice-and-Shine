extends Node2D
@onready var front_bg: Sprite2D = $FrontBG
@onready var top_down_bg: Sprite2D = $TopDownBG

@onready var steps: Node2D = $Steps
@onready var blanching: Node2D = $Steps/Blanching
@onready var new_bowl_parent: Node2D = $Steps/NewBowlParent
@onready var ice: Node2D = $Steps/Ice
@onready var sauteing: Node2D = $Steps/Sauteing
@onready var additional_ingredients: Node2D = $Steps/AdditionalIngredient
@onready var draining: Node2D = $Steps/Drainings
@onready var noodles: Node2D = $Steps/Noodles
@onready var vegetables: Node2D = $Steps/Vegetables
@onready var seasoning: Node2D = $Steps/Seasoning

@onready var cooking_bowl: Control = $Steps/Blanching/CookingBowl
@onready var oil: Oil = $Steps/Sauteing/Oil

# Ice Stuff
signal enter_ice
signal ice_done
@onready var ice_bowl: Node2D = $Steps/Ice/IceBowl
var ice_qty := 0:
	set(value):
		ice_qty = value
		if ice_qty > 100:
			set_process(false)
			ice_done.emit()
var filling_ice := false

# Blanching Vegetables
var snappeas_added := false
var carrots_added := false
var cabbage_added := false

# Sauteing Vegetables
signal saute_start
signal saute_finished
var onion_added := false
var garlic_added := false
var pork_added := false
var chinese_added := false
var soysauce_added := false
var oystersauce_added := false


func _process(_delta: float) -> void:
	if filling_ice: ice_qty += 1

func _ready() -> void:
	ice_bowl.snap_to_og_pos = true
	ice_bowl.set_og_pos()
	oil.ice_bowl.snap_to_og_pos = true
	oil.set_og_pos()
	for i in steps.get_children(): i.position.x += get_viewport().get_visible_rect().size.x
	
	GlobalVars.item_enter(blanching)
	
func _on_faucet_faucet_done() -> void:
	cooking_bowl.set_process(false)
	cooking_bowl.reparent(new_bowl_parent)
	GlobalVars.successind(get_tree())
	await GlobalVars.successIndEnd
	
	enter_ice.emit()
	
func _on_enter_ice() -> void:
	GlobalVars.item_exit(blanching)
	var vw = get_viewport_rect()
	create_tween().tween_property(cooking_bowl, "global_position", Vector2(vw.size.x/2, vw.size.y/2), 0.5).set_trans(Tween.TRANS_CUBIC)
	GlobalVars.item_enter(ice)

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area is CookingBowlArea: filling_ice = true
func _on_area_2d_area_exited(area: Area2D) -> void:
	if area is CookingBowlArea: filling_ice = false

func _on_ice_done() -> void:
	GlobalVars.item_exit(ice)
	GlobalVars.item_exit(new_bowl_parent)
	
	create_tween().tween_property(top_down_bg, "modulate:a", 1, 0.5).set_trans(Tween.TRANS_CUBIC)
	
	GlobalVars.item_enter(vegetables)
	
func check_mixbowl_contents() -> void:
	if snappeas_added and carrots_added and cabbage_added:
		GlobalVars.successind(get_tree().current_scene)
		await GlobalVars.successIndEnd
		
		saute_start.emit()
	elif onion_added and garlic_added and pork_added and chinese_added and soysauce_added and oystersauce_added:
		
		# ADD MIXING HERE
		
		GlobalVars.successind(get_tree().current_scene)
		await GlobalVars.successIndEnd
		
		saute_finished.emit()

func _on_saute_start() -> void:
	GlobalVars.item_exit(vegetables)
	GlobalVars.item_enter(sauteing)
	
func _on_pan_area_entered(area: Area2D) -> void:
	if area is Oil: GlobalVars.item_enter(additional_ingredients)

func _on_saute_finished() -> void:
	GlobalVars.item_enter(draining)
	
	
