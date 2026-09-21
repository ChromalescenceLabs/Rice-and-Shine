extends Node2D
@onready var hashbrown_peel: Node2D = $Hashbrowns
@onready var grating_hashbrowns: Node2D = $GratingHashbrowns

func _on_grated_full_mouse_entered() -> void:
	pass # Replace with function body.

func _ready() -> void:
	hashbrown_peel.position.x += get_viewport().get_visible_rect().size.x
	grating_hashbrowns.position.x += get_viewport().get_visible_rect().size.x
	GlobalVars.item_enter(hashbrown_peel)

func _on_hashbrowns_peeled() -> void:
	GlobalVars.successind(self)
	await GlobalVars.successIndEnd
	
	GlobalVars.item_exit(hashbrown_peel)
	hashbrown_peel.process_mode = Node.PROCESS_MODE_DISABLED
	GlobalVars.item_enter(grating_hashbrowns)
	grating_hashbrowns.process_mode = Node.PROCESS_MODE_INHERIT
