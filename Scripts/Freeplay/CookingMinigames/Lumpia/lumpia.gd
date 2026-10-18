extends Node2D
const CHOPPABLE_CARROT = preload("uid://kqe7h1lfhspa")
const MINCEABLE_PORK = preload("uid://dbhjxs8qkv73p")

var item_og_pos : Vector2

@onready var front_bg: Sprite2D = $FrontBG
@onready var top_down_bg: Sprite2D = $TopDownBG

@onready var slicing_mincing: Node2D = $"Slicing&Mincing"
@onready var filling_mix: Node2D = $FillingMix
@onready var pouring_mix: Node2D = $PouringMix
@onready var mixing: Node2D = $Mixing
@onready var wrapping: Node2D = $Wrapping
@onready var frying: Node2D = $Frying

# SLICING AND MINCING
signal mincing_finished
@onready var choppable_garlic: Area2D = $"Slicing&Mincing/ChoppableGarlic"
var choppable_garlic_og_pos : Vector2

# FILLING MIX
signal filling_finished
@onready var mix_bowl: Sprite2D = $FillingMix/MixBowl
@onready var ingredient_bowls: Node2D = $FillingMix/IngredientBowls
var groundpork_added : bool = false
var mincedonion_added : bool = false
var carrot_added : bool = false
var parsley_added : bool = false

# POURING MIX
signal pouring_finished
@onready var pouring_bowl: BowlArea = $PouringMix/PouringBowl
@onready var oil_progress: ProgressBar = $PouringMix/PouringBowl/OilProgress

# MIXING
signal mixing_finished

# WRAPPING
signal wrapping_finished

func _ready() -> void:
	choppable_garlic_og_pos = choppable_garlic.position
	slicing_mincing.position.x += get_viewport().get_visible_rect().size.x
	
	filling_mix.position.x += get_viewport().get_visible_rect().size.x
	pouring_mix.position.x += get_viewport().get_visible_rect().size.x
	mixing.position.x += get_viewport().get_visible_rect().size.x
	wrapping.position.x += get_viewport().get_visible_rect().size.x
	frying.position.x += get_viewport().get_visible_rect().size.x
	
	#GlobalVars.item_enter(slicing_mincing)
	GlobalVars.item_enter(pouring_mix)
	choppable_garlic.progbar_fade_in()
	
func _on_choppable_garlic_chopped_garlic_finished() -> void:
	GlobalVars.item_exit(pouring_mix)
	await GlobalVars.itemExited
	
	choppable_garlic.queue_free()
	
func _on_choppable_garlic_tree_exited() -> void:
	var carrot = CHOPPABLE_CARROT.instantiate()
	carrot.global_position = choppable_garlic_og_pos
	if get_viewport(): carrot.position.x += get_viewport().get_visible_rect().size.x * 2
	slicing_mincing.add_child(carrot)
	GlobalVars.indiv_item_enter(carrot)
	carrot.progbar_fade_in()
	
	await carrot.tree_exited
	
	var pork = MINCEABLE_PORK.instantiate()
	pork.global_position = choppable_garlic_og_pos
	pork.position.x += get_viewport().get_visible_rect().size.x * 2
	slicing_mincing.add_child(pork)
	GlobalVars.indiv_item_enter(pork)
	pork.progbar_fade_in()
	
	await pork.tree_exited
	
	GlobalVars.item_enter(filling_mix)
	mincing_finished.emit()


func _on_mincing_finished() -> void:
	GlobalVars.item_enter(filling_mix)
	
func check_mixbowl_contents():
	if groundpork_added and mincedonion_added and carrot_added and parsley_added:
		filling_finished.emit()

func _on_filling_finished() -> void:
	GlobalVars.successind(get_tree().current_scene)
	await GlobalVars.successIndEnd
	
	GlobalVars.item_exit(filling_mix)
	GlobalVars.item_enter(pouring_mix)
	
	create_tween().tween_property(top_down_bg, "modulate:a", 0, 0.3).set_trans(Tween.TRANS_CUBIC)
	
func _on_oil_progress_value_changed(value: float) -> void:
	if value >= 100:
		pouring_bowl.monitorable = false
		pouring_bowl.monitoring = false
		
		GlobalVars.successind(get_tree().current_scene)
		await GlobalVars.successIndEnd
		
		pouring_finished.emit()
		
func _on_pouring_finished() -> void:
	GlobalVars.item_exit(pouring_mix)
	GlobalVars.item_enter(mixing)
	
	create_tween().tween_property(top_down_bg, "modulate:a", 1, 0.3).set_trans(Tween.TRANS_CUBIC)
	
func _on_mixing_finished() -> void:
	GlobalVars.item_exit(mixing)
	GlobalVars.item_enter(wrapping)


func _on_wrapping_finished() -> void:
	GlobalVars.item_exit(wrapping)
	GlobalVars.item_enter(frying)
