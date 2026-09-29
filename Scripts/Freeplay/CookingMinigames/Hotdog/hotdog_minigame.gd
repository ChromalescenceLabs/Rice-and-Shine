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
signal stick_finished
signal change_stick
@onready var stick: Node2D = $Stick
@onready var other_stick_nodes: Node2D = $OtherStickNodes
@export var stickw_comp_1: Node2D
@export var stickw_comp_2: Node2D
@export var stickw_comp_3: Node2D
@onready var mallows_bag: TextureRect = $Stick/MallowsBag
@onready var hotdog_bowl: TextureRect = $Stick/HotdogBowl
var sticks: int = 0:
	set(value):
		if not value == sticks:
			sticks = value
			if not sticks >= 3:
				change_stick.emit()
				match sticks:
					1: stick_exit(stickw_comp_1, stickw_comp_2)
					2: stick_exit(stickw_comp_2, stickw_comp_3)
					3: GlobalVars.item_exit(stickw_comp_3)
				mallows_bag.mouse_filter = Control.MOUSE_FILTER_PASS
				hotdog_bowl.mouse_filter = Control.MOUSE_FILTER_PASS
			else:
				stick_finished.emit()

func stick_exit(sticknode, nextnode):
	GlobalVars.item_exit(sticknode)
	nextnode.reparent(stick, true)
	create_tween().tween_property(nextnode, "position", Vector2(0, 0), 1.5).set_trans(Tween.TRANS_ELASTIC)
	await GlobalVars.itemExited
	sticknode.queue_free()
	


func _ready() -> void:
	frying.position.x += get_viewport().get_visible_rect().size.x
	slicing.position.x += get_viewport().get_visible_rect().size.x
	chopping.position.x += get_viewport().get_visible_rect().size.x
	stick.position.x += get_viewport().get_visible_rect().size.x
	other_stick_nodes.position.x += get_viewport().get_visible_rect().size.x
	
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


func _on_stick_finished() -> void:
	SceneLoader.load_scene("uid://b5ufcgv0qaktk", 1)
