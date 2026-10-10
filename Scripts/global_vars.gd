extends Node

# Player Info
var current_db : float = -25
var is_customer_serving: bool = false


# Systems

signal successIndEnd
signal instructions_changed
signal itemEntered
signal itemExited
signal enterDone

const SUCCIND = preload("uid://beppy36ki8xum")
var instructions : String:
	set(value):
		instructions = value
		instructions_changed.emit(value)


func successind(tree):
	var success = SUCCIND.instantiate()
	success.position = tree.get_viewport().get_visible_rect().size / 2
	tree.add_child(success)
	
	await success.tree_exited
	successIndEnd.emit()
	
func item_enter(item) -> void:
	var tw = create_tween().tween_property(item, "position", Vector2(0,0), 2).set_trans(Tween.TRANS_ELASTIC)
	await tw.finished
	itemEntered.emit()
	instructions_changed.emit(item)
	var t=create_tween().tween_property(item, "position", Vector2(0,0), 2).set_trans(Tween.TRANS_ELASTIC)
	await t.finished
	enterDone.emit()
func item_exit(item) -> void:
	var vw = get_viewport().size.x
	var tw = create_tween().tween_property(item, "position", Vector2(vw * -1, 0), 2).set_trans(Tween.TRANS_ELASTIC)
	await tw.finished
	itemExited.emit()

# Customer Serving Funcs

	
	
