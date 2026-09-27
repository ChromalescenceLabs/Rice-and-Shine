extends Node2D

# SLICING
@warning_ignore("unused_signal")
signal slicing_finished
const SLICEABLE_HDOGS = preload("uid://dplwtlc2jhxoo")
@onready var slicing: Node2D = $Slicing
@onready var chopping_board: Sprite2D = $Slicing/ChoppingBoard
@onready var plate: Sprite2D = $Slicing/Plate
var sliced_hotdog: int = 0:
	set(value):
		if not value == sliced_hotdog:
			sliced_hotdog = value
			if not sliced_hotdog >= 3:
				var hdog = SLICEABLE_HDOGS.instantiate()
				hdog.position = chopping_board.position
				hdog.position.x += get_viewport().get_visible_rect().size.x
				slicing.add_child(hdog)
				create_tween().tween_property(hdog, "position", chopping_board.position, 1.5).set_trans(Tween.TRANS_ELASTIC)
			else:
				slicing_finished.emit()

# FRYING
@warning_ignore("unused_signal")
signal frying_finished
@onready var frying: Node2D = $Frying
@onready var hdog_pan: HdogPan = $Frying/HdogPan
var frying_hotdog_no: int = 3

# CHOPPING
signal chopping_finished
@onready var chopping_board_chopping: Sprite2D = $Chopping/ChoppingBoard
@onready var chopping: Node2D = $Chopping
const CHOPPABLE_HDOGS = preload("uid://dj3rvq375j1te")
var chopped_hdog: int = 0:
	set(value):
		if not value == chopped_hdog:
			chopped_hdog = value
			if not chopped_hdog >= 3:
				var chdog = CHOPPABLE_HDOGS.instantiate()
				chdog.position = chopping_board_chopping.position
				chdog.position.x += get_viewport().get_visible_rect().size.x
				chopping.add_child(chdog)
				create_tween().tween_property(chdog, "position", chopping_board_chopping.position, 1.5).set_trans(Tween.TRANS_ELASTIC)
			else:
				chopping_finished.emit()

# STICK
@onready var stick: Node2D = $Stick


func _ready() -> void:
	frying.position.x += get_viewport().get_visible_rect().size.x
	slicing.position.x += get_viewport().get_visible_rect().size.x
	chopping.position.x += get_viewport().get_visible_rect().size.x
	
	GlobalVars.item_enter(slicing)


func _on_frying_finished() -> void:
	GlobalVars.item_exit(frying)
	GlobalVars.item_enter(chopping)

func _on_slicing_finished() -> void:
	GlobalVars.item_exit(slicing)
	GlobalVars.item_enter(frying)

func _on_chopping_finished() -> void:
	GlobalVars.item_exit(chopping)
	GlobalVars.item_enter(stick)
