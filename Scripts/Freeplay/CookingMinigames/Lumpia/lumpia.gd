extends Node2D
const CHOPPABLE_CARROT = preload("uid://kqe7h1lfhspa")

@onready var slicing_mincing: Node2D = $"Slicing&Mincing"
@onready var filling_mix: Node2D = $FillingMix
@onready var wrapping: Node2D = $Wrapping
@onready var frying: Node2D = $Frying

func _ready() -> void:
	slicing_mincing.position.x += get_viewport().get_visible_rect().size.x
	filling_mix.position.x += get_viewport().get_visible_rect().size.x
	wrapping.position.x += get_viewport().get_visible_rect().size.x
	frying.position.x += get_viewport().get_visible_rect().size.x
	
	GlobalVars.item_enter(slicing_mincing)

func _on_choppable_garlic_tree_exited() -> void:
	slicing_mincing.position.x += get_viewport().get_visible_rect().size.x
	var carrot = CHOPPABLE_CARROT.instantiate()
	slicing_mincing.add_child(carrot)
	
	GlobalVars.item_enter(slicing_mincing)
