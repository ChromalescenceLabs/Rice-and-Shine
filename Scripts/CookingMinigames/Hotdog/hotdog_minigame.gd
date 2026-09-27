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
				print(hdog.position)
				slicing.add_child(hdog)
				create_tween().tween_property(hdog, "position", chopping_board.position, 1).set_trans(Tween.TRANS_ELASTIC)
			else:
				slicing_finished.emit()

# FRYING
@warning_ignore("unused_signal")
signal frying_finished
@onready var frying: Node2D = $Frying
@onready var hdog_pan: HdogPan = $Frying/HdogPan
var frying_hotdog_no: int = 3

func _ready() -> void:
	frying.position.x += get_viewport().get_visible_rect().size.x
	slicing.position.x += get_viewport().get_visible_rect().size.x
	
	GlobalVars.item_enter(slicing)


func _on_frying_finished() -> void:
	GlobalVars.item_exit(frying)

func _on_slicing_finished() -> void:
	GlobalVars.item_exit(slicing)
	GlobalVars.item_enter(frying)
