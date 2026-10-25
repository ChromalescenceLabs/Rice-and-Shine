extends Node2D
@onready var steps: Node2D = $Steps
@onready var blanching: Node2D = $Steps/Blanching
@onready var draining: Node2D = $Steps/Draining
@onready var sauteing: Node2D = $Steps/Sauteing
@onready var additional_ingredients: Node2D = $Steps/AdditionalIngredients
@onready var noodles: Node2D = $Steps/Noodles
@onready var vegetables: Node2D = $Steps/Vegetables
@onready var seasoning: Node2D = $Steps/Seasoning

# Enter Bowl with Ice
signal enter_ice

func _ready() -> void:
	for i in steps.get_children(): i.position.x += get_viewport().get_visible_rect().size.x
	
func _on_faucet_faucet_done() -> void:
	GlobalVars.successind(get_tree())
	await GlobalVars.successIndEnd
	
	enter_ice.emit()
	
	


func _on_enter_ice() -> void:
	pass # Replace with function body.
