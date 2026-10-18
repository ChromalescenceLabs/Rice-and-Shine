extends Node2D
const CHOPPABLE_CARROT = preload("uid://kqe7h1lfhspa")

@onready var slicing_mincing: Node2D = $"Slicing&Mincing"
@onready var filling_mix: Node2D = $FillingMix
@onready var wrapping: Node2D = $Wrapping
@onready var frying: Node2D = $Frying

# SLICING AND MINCING
signal mincing_finished
@onready var choppable_garlic: Area2D = $"Slicing&Mincing/ChoppableGarlic"
var slicing_og_pos : Vector2
var choppable_garlic_og_pos : Vector2

# FILLING MIX
signal filling_finished


func _ready() -> void:
	slicing_og_pos = slicing_mincing.global_position
	choppable_garlic_og_pos = choppable_garlic.global_position
	slicing_mincing.position.x += get_viewport().get_visible_rect().size.x
	
	
	filling_mix.position.x += get_viewport().get_visible_rect().size.x
	wrapping.position.x += get_viewport().get_visible_rect().size.x
	frying.position.x += get_viewport().get_visible_rect().size.x
	
	GlobalVars.item_enter(slicing_mincing)
	choppable_garlic.progbar_fade_in()
	
func _on_choppable_garlic_chopped_garlic_finished() -> void:
	GlobalVars.item_exit(slicing_mincing)
	await GlobalVars.itemExited
	
	choppable_garlic.queue_free()
	
func _on_choppable_garlic_tree_exited() -> void:
	slicing_mincing.position = slicing_og_pos
	slicing_mincing.position.x += get_viewport().get_visible_rect().size.x
	var carrot = CHOPPABLE_CARROT.instantiate()
	carrot.global_position = choppable_garlic_og_pos
	slicing_mincing.add_child(carrot)
	carrot.progbar_fade_in()
	
	GlobalVars.item_enter(slicing_mincing)
	
	await carrot.tree_exited
	
	mincing_finished.emit()


func _on_mincing_finished() -> void:
	GlobalVars.item_enter(filling_mix)
