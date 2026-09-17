extends Node

signal instructions_changed

var current_db : float = -25

var instructions : String:
	set(value):
		instructions = value
		instructions_changed.emit(value)
