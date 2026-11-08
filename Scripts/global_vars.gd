extends Node

# Player Info
var current_db : float = -25
var is_customer_serving: bool = false
var current_scene

# Systems
signal successIndEnd
signal itemEntered
signal itemExited
signal shakeDone
signal customerDone

const SUCCIND = preload("uid://beppy36ki8xum")

func successind(tree):
	var success = SUCCIND.instantiate()
	success.position = tree.get_viewport().get_visible_rect().size / 2
	tree.add_child(success)
	
	await success.tree_exited
	successIndEnd.emit()
	
func item_enter(item) -> void:
	item.visible=true
	var tw = create_tween().tween_property(item, "position", Vector2(0,0), 2).set_trans(Tween.TRANS_ELASTIC)
	await tw.finished
	itemEntered.emit(item)

func indiv_item_enter(item, position : Vector2 = Vector2(get_viewport().size.x/2, get_viewport().size.y/2)) -> void:
	var tw = create_tween().tween_property(item, "global_position", position, 2).set_trans(Tween.TRANS_ELASTIC)
	await tw.finished
	itemEntered.emit(item)

func item_exit(item) -> void:
	var vw = get_viewport().size.x
	var tw = create_tween().tween_property(item, "position", Vector2(vw * -1, 0), 2).set_trans(Tween.TRANS_ELASTIC)
	await tw.finished
	itemExited.emit()

func shake(item):
	var t = create_tween()
	t.tween_property(item, "position:x", item.position.x+30, .1).set_trans(Tween.TRANS_CUBIC)
	t.tween_property(item, "position:x", item.position.x-30, .1).set_trans(Tween.TRANS_CUBIC)
	t.tween_property(item, "position:x", item.position.x, .1).set_trans(Tween.TRANS_CUBIC)
	shakeDone.emit()

	
# Customer Serving
signal paid(amt: float)
var character_name : String
var character_order : String
# Change this value when adding or deducting pay. PUT THE VALUE OF THE AMOUNT TO BE DEDUCTED/ADDED, not the final amount
var payment : float = 0.0:
	set(value):
		payment += value
		paid.emit(value)
		
var day : int
var week : int
	
# Unlocks
var unlocked_foods : Array = ["rice"]
var unlocked_customers : Array = ["marites", "student", "lolo", "tatay"]
var customer_weights : PackedFloat32Array = []

var tutorial_finished : bool = false
var w1_days : int = 1
var w2_days : int = 0
var w3_days : int = 0
var w4_days : int = 0
var w5_days : int = 0
var w6_days : int = 0
var w7_days : int = 0

func _ready() -> void:
	append_equal_weights()

func append_equal_weights():
	var customers_num : int = unlocked_customers.size()
	var weight = 100.0 / customers_num
	for i in customers_num:
		customer_weights.append(weight)
