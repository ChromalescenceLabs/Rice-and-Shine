extends Node2D
@onready var peel: Node2D = $peel
@onready var grate: Node2D = $grate

func _on_grated_full_mouse_entered() -> void:
	pass # Replace with function body.

func _ready() -> void:
	peel.position.x += get_viewport().get_visible_rect().size.x
	grate.position.x += get_viewport().get_visible_rect().size.x
	
	peel.process_mode = Node.PROCESS_MODE_DISABLED
	GlobalVars.item_enter(peel)


func _on_hashbrowns_peeled() -> void:
	GlobalVars.successind(self)
	await GlobalVars.successIndEnd
	
	GlobalVars.item_exit(peel)
	peel.process_mode = Node.PROCESS_MODE_DISABLED
	GlobalVars.item_enter(grate)
	grate.process_mode = Node.PROCESS_MODE_INHERIT
