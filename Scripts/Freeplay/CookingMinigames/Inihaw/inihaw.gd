extends Node2D
@onready var front_bg: Sprite2D = $FrontBG
@onready var top_down_bg: Sprite2D = $TopDownBG

# CHOPPING PORK BELLIES
signal chopping_finished
@onready var chopping_board_chopping: Sprite2D = $Chopping/ChoppingBoard
@onready var chopping: Node2D = $Chopping
const CHOPPABLE_PBELLY = preload("uid://cy1qe3w0ip4cu")
var chopped_pbelly: int = 0:
	set(value):
		if not value == chopped_pbelly:
			chopped_pbelly = value
			if not chopped_pbelly >= 3:
				var chdog = CHOPPABLE_PBELLY.instantiate()
				chdog.position = chopping_board_chopping.position
				chdog.position.x += get_viewport().get_visible_rect().size.x
				chopping.add_child(chdog)
				create_tween().tween_property(chdog, "position", chopping_board_chopping.position, 1.5).set_trans(Tween.TRANS_ELASTIC)
			else:
				chopping_finished.emit()
				
# MINCING
signal mincing_finished

@onready var mincing: Node2D = $Mincing
@onready var choppable_garlic: Area2D = $Mincing/ChoppableGarlic

# PREPPING
@onready var prepping: Node2D = $Prepping
@onready var inihaw_liquids: Node2D = $Prepping/InihawLiquids
@onready var progress_bars: Node2D = $Prepping/BowlFillArea/ProgressBars

func _ready() -> void:
	chopping.position.x += get_viewport().get_visible_rect().size.x
	mincing.position.x += get_viewport().get_visible_rect().size.x
	prepping.position.x += get_viewport().get_visible_rect().size.x
	front_bg.modulate.a = 0
	
	#GlobalVars.item_enter(chopping)
	create_tween().tween_property(top_down_bg, "modulate:a", 1, 0.3).set_trans(Tween.TRANS_CUBIC)

	GlobalVars.item_enter(prepping)
	inihaw_liquids.check_liquid("Soy")

func _on_chopping_finished() -> void:
	GlobalVars.item_enter(mincing)
	choppable_garlic.progbar_fade_in()

func _on_choppable_garlic_chopped_garlic_finished() -> void:
	GlobalVars.item_exit(chopping)
	GlobalVars.item_exit(mincing)
	chopping.position.x += get_viewport().get_visible_rect().size.x
	
	create_tween().tween_property(top_down_bg, "modulate:a", 1, 0.3).set_trans(Tween.TRANS_CUBIC)

	GlobalVars.item_enter(prepping)

# MIXING LOGIC
func _on_progress_bars_soy_sauce_done() -> void:
	GlobalVars.item_exit(inihaw_liquids)
	await GlobalVars.itemExited
	inihaw_liquids.visible = false
	inihaw_liquids.global_position = Vector2(989.0, 384.0)
	inihaw_liquids.position.x += get_viewport().get_visible_rect().size.x
	
	inihaw_liquids.check_liquid("Calamansi")
	
	inihaw_liquids.visible = true
	create_tween().tween_property(inihaw_liquids, "position", Vector2(989.0, 384.0), 2).set_trans(Tween.TRANS_ELASTIC)

func _on_progress_bars_calamansi_done() -> void:
	GlobalVars.item_exit(inihaw_liquids)
	await GlobalVars.itemExited
	inihaw_liquids.visible = false
	inihaw_liquids.global_position = Vector2(989.0, 384.0)
	inihaw_liquids.position.x += get_viewport().get_visible_rect().size.x
	
	inihaw_liquids.check_liquid("Ketchup")
	
	inihaw_liquids.visible = true
	create_tween().tween_property(inihaw_liquids, "position", Vector2(989.0, 384.0), 2).set_trans(Tween.TRANS_ELASTIC)

func _on_progress_bars_ketchup_done() -> void:
	GlobalVars.item_exit(inihaw_liquids)
	await GlobalVars.itemExited
	inihaw_liquids.visible = false
	inihaw_liquids.global_position = Vector2(989.0, 384.0)
	inihaw_liquids.position.x += get_viewport().get_visible_rect().size.x
	
	inihaw_liquids.check_liquid("Sprite")
	
	inihaw_liquids.visible = true
	create_tween().tween_property(inihaw_liquids, "position", Vector2(989.0, 384.0), 2).set_trans(Tween.TRANS_ELASTIC)

func _on_progress_bars_sprite_done() -> void:
	GlobalVars.item_exit(inihaw_liquids)
	await GlobalVars.itemExited
