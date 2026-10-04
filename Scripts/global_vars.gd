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
	var tw = create_tween().tween_property(item, "position", Vector2(0,0), 2).set_trans(Tween.TRANS_ELASTIC)
	await tw.finished
	itemEntered.emit(item)

func item_exit(item) -> void:
	var vw = get_viewport().size.x
	var tw = create_tween().tween_property(item, "position", Vector2(vw * -1, 0), 2).set_trans(Tween.TRANS_ELASTIC)
	await tw.finished
	itemExited.emit()

# Customer Serving Vars
signal foodValueChanged(var_name : String, new_value : int, current_state)

var rice_value : int = 5:
	set(value):
		if not rice_value == value:
			rice_value = value
			
		var current_state
		
		if rice_value <= 0:
			rice_value = 0
			current_state = "EMPTY"
		else:
			current_state = "FILLED"
			
		foodValueChanged.emit("rice_value", rice_value, current_state)

var pcake_value : int = 5:
	set(value):
		if not pcake_value == value:
			pcake_value = value
		var current_state
		
		if pcake_value <= 0:
			pcake_value = 0
			current_state = "EMPTY"
		else:
			current_state = "FILLED"
			
		foodValueChanged.emit("pcake_value", pcake_value, current_state)

var hbrown_value : int = 5:
	set(value):
		if not hbrown_value == value:
			hbrown_value = value
		
		var current_state
		
		if hbrown_value <= 0:
			hbrown_value = 0
			current_state = "EMPTY"
		else:
			current_state = "FILLED"
			
		foodValueChanged.emit("hbrown_value", hbrown_value, current_state)

var rice_cont_state : String = "EMPTY" if rice_value <= 0 else "FILLED"
var pcake_cont_state : String = "EMPTY" if pcake_value <= 0 else "FILLED"
var hbrown_cont_state : String = "EMPTY" if hbrown_value <= 0 else "FILLED"

# Customer Serving Funcs

	
	
