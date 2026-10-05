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
signal prepSugarDone
@onready var prepping: Node2D = $Prepping
@onready var inihaw_liquids: Node2D = $Prepping/InihawLiquids
@onready var progress_bars: Node2D = $Prepping/BowlFillArea/ProgressBars
@onready var prep_sugar: Node2D = $PrepSugar
@onready var sugar: TextureRect = $PrepSugar/Sugar
var sugar_no: int = 0:
	set(value):
		if not value == sugar_no:
			sugar_no = value
			
			if sugar_no >= 3:
				prepSugarDone.emit()
				
# SHAKING
signal shake_start
signal shake_end
@onready var shaking: Node2D = $Shaking
var shakes: int = 0:
	set(value):
		if not value == shakes:
			shakes = value
			print(shakes)
			
			if shakes >= 3:
				shake_end.emit()
		


func _ready() -> void:
	chopping.position.x += get_viewport().get_visible_rect().size.x
	mincing.position.x += get_viewport().get_visible_rect().size.x
	prepping.position.x += get_viewport().get_visible_rect().size.x
	prep_sugar.position.x += get_viewport().get_visible_rect().size.x
	shaking.position.x += get_viewport().get_visible_rect().size.x
	
	GlobalVars.item_enter(chopping)
	
func _on_chopping_finished() -> void:
	GlobalVars.item_enter(mincing)
	choppable_garlic.progbar_fade_in()

func _on_choppable_garlic_chopped_garlic_finished() -> void:
	GlobalVars.item_exit(chopping)
	GlobalVars.item_exit(mincing)
	chopping.position.x += get_viewport().get_visible_rect().size.x
	
	create_tween().tween_property(top_down_bg, "modulate:a", 0, 0.3).set_trans(Tween.TRANS_CUBIC)

	GlobalVars.item_enter(prepping)
	inihaw_liquids.check_liquid("Soy")

# MIXING LOGIC
func _on_progress_bars_soy_sauce_done() -> void:
	var tw = create_tween().tween_property(inihaw_liquids, "position", Vector2(-1000, 384.0), 2).set_trans(Tween.TRANS_ELASTIC)
	await tw.finished
	inihaw_liquids.visible = false
	inihaw_liquids.global_position = Vector2(989.0, 384.0)
	inihaw_liquids.position.x += get_viewport().get_visible_rect().size.x
	
	inihaw_liquids.check_liquid("Calamansi")
	
	inihaw_liquids.visible = true
	create_tween().tween_property(inihaw_liquids, "position", Vector2(989.0, 384.0), 2).set_trans(Tween.TRANS_ELASTIC)

func _on_progress_bars_calamansi_done() -> void:
	var tw = create_tween().tween_property(inihaw_liquids, "position", Vector2(-1000, 384.0), 2).set_trans(Tween.TRANS_ELASTIC)
	await tw.finished
	inihaw_liquids.visible = false
	inihaw_liquids.global_position = Vector2(989.0, 384.0)
	inihaw_liquids.position.x += get_viewport().get_visible_rect().size.x
	
	inihaw_liquids.check_liquid("Ketchup")
	
	inihaw_liquids.visible = true
	create_tween().tween_property(inihaw_liquids, "position", Vector2(989.0, 384.0), 2).set_trans(Tween.TRANS_ELASTIC)

func _on_progress_bars_ketchup_done() -> void:
	var tw = create_tween().tween_property(inihaw_liquids, "position", Vector2(-1000, 384.0), 2).set_trans(Tween.TRANS_ELASTIC)
	await tw.finished
	inihaw_liquids.visible = false
	inihaw_liquids.global_position = Vector2(989.0, 384.0)
	inihaw_liquids.position.x += get_viewport().get_visible_rect().size.x
	
	inihaw_liquids.check_liquid("Sprite")
	
	inihaw_liquids.visible = true
	create_tween().tween_property(inihaw_liquids, "position", Vector2(989.0, 384.0), 2).set_trans(Tween.TRANS_ELASTIC)

func _on_progress_bars_sprite_done() -> void:
	create_tween().tween_property(inihaw_liquids, "position", Vector2(-1000, 384.0), 2).set_trans(Tween.TRANS_ELASTIC)
	
	GlobalVars.item_enter(prep_sugar)

func _on_prep_sugar_done() -> void:
	sugar.mouse_filter = Control.MOUSE_FILTER_IGNORE
	GlobalVars.successind(get_tree().current_scene)
	await GlobalVars.successIndEnd
	
	GlobalVars.item_exit(prep_sugar)
	
	GlobalVars.item_enter(shaking)
	shake_start.emit()

func _on_shake_end() -> void:
	GlobalVars.successind(get_tree().current_scene)
	await GlobalVars.successIndEnd
	
	GlobalVars.item_exit(shaking)
	GlobalVars.item_exit(prepping)
	
	SceneLoader.load_scene("uid://b5ufcgv0qaktk", 1.5)
