extends Node

signal successIndEnd
signal instructions_changed

var current_db : float = -25
const SUCCIND = preload("uid://beppy36ki8xum")

var instructions : String:
	set(value):
		instructions = value
		instructions_changed.emit(value)

func successind(tree):
	var success = SUCCIND.instantiate()
	success.position = tree.get_viewport().get_visible_rect().size / 2
	tree.add_child(success)
	print(success.position)
	
	await success.tree_exited
	
	successIndEnd.emit()
	
func item_enter(item) -> void:
	create_tween().tween_property(item, "position", Vector2(0,0), 2).set_trans(Tween.TRANS_ELASTIC)
	
func item_exit(item) -> void:
	var vw = get_viewport().size.x
	create_tween().tween_property(item, "position", Vector2(vw * -1, 0), 2).set_trans(Tween.TRANS_ELASTIC)
