extends Node

# Player Info
var current_db : float = -25
var is_customer_serving: bool = false


# Systems

signal successIndEnd
signal itemEntered
signal itemExited

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

func item_exit(item) -> void:
	var vw = get_viewport().size.x
	var tw = create_tween().tween_property(item, "position", Vector2(vw * -1, 0), 2).set_trans(Tween.TRANS_ELASTIC)
	await tw.finished
	item.visible=false
	itemExited.emit()

# Unlocks
var unlocked_foods : Array = ["rice", "pancake", "hashbrown"]

	
	
