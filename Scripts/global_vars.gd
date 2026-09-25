extends Node

# Player Info
var current_db : float = -25
var is_customer_serving: bool = false


# Systems

signal successIndEnd
signal instructions_changed

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

func _physics_process(delta: float) -> void:
	print(rice_value)

# Customer Serving Vars
signal foodValueChanged(var_name : String, new_value : int, current_state)

var rice_value : int = 5:
	set(value):
		var current_state = food_val_changed(value, rice_value)
		rice_cont_state = current_state
		foodValueChanged.emit("rice_value", rice_value, current_state)

var pcake_value : int = 5:
	set(value):
		var current_state = food_val_changed(value, pcake_value)
		pcake_cont_state = current_state
		foodValueChanged.emit("pcake_value", pcake_value, current_state)

var hbrown_value : int = 5:
	set(value):
		var current_state = food_val_changed(value, hbrown_value)
		hbrown_cont_state = current_state
		foodValueChanged.emit("hbrown_value", hbrown_value, current_state)

var rice_cont_state : String = "EMPTY" if rice_value <= 0 else "FILLED"
var pcake_cont_state : String = "EMPTY" if pcake_value <= 0 else "FILLED"
var hbrown_cont_state : String = "EMPTY" if hbrown_value <= 0 else "FILLED"

func food_val_changed(value, food_value):
	if food_value != value:
		food_value = value
		var current_state
		
		if food_value <= 0:
			food_value = 0
			current_state = "EMPTY"
		else:
			current_state = "FILLED"
		
		return current_state

# Customer Serving Funcs
