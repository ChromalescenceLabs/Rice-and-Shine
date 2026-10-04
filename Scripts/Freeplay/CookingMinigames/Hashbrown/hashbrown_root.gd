extends Node2D
@onready var peel: Node2D = $peel
@onready var grate: Node2D = $grate

func _ready() -> void:
	peel.position.x += get_viewport().get_visible_rect().size.x
	grate.position.x += get_viewport().get_visible_rect().size.x
	
	GlobalVars.item_enter(peel)


func _on_peel_peeled() -> void:
	GlobalVars.successind(self)
	await GlobalVars.successIndEnd
	
	GlobalVars.item_exit(peel)
	peel.set_process(false)
	GlobalVars.item_enter(grate)


func _on_grated_full_grated() -> void:
	GlobalVars.successind(self)
	await GlobalVars.successIndEnd
