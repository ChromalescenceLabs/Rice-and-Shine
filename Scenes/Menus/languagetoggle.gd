extends VBoxContainer

@onready var english: CheckBox = $ENGLISH
@onready var tagalog: CheckBox = $TAGALOG
@onready var both: CheckBox = $BOTH

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func _on_english_toggled(toggled_on: bool) -> void:
	if tagalog.toggle_mode == true:
		tagalog.toggle_mode = false
	elif both.toggle_mode == true:
		both.toggle_mode = false
	else: 
		english.toggle_mode = true
		print("eng mode only one on")

func _on_tagalog_toggled(toggled_on: bool) -> void:
	if english.toggle_mode == true:
		english.toggle_mode = false
	elif both.toggle_mode == true:
		both.toggle_mode = false
	else:
		tagalog.toggle_mode = true
		print("tag mode only one on")

func _on_both_toggled(toggled_on: bool) -> void:
	if english.toggle_mode == true:
		english.toggle_mode = false
	elif tagalog.toggle_mode == true:
		tagalog.toggle_mode = false
	else: 
		both.toggle_mode = true
		print("both mode only one on")
