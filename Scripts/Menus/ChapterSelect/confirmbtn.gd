extends Button
#i feel like yandev whenever i code, this feels embarassing
@export var CHAP1: CanvasItem
@export var CHAP2: CanvasItem
@export var CHAP3: CanvasItem
@onready var title: RichTextLabel = get_node("../../../../TITLE")
@onready var status: RichTextLabel = get_node("../../../../STATUS")
@onready var desc: RichTextLabel = get_node("../../../../DESCRIPTION")

const CH1SCENE = "res://Scenes/Menus/week_select.tscn"

func _on_pressed() -> void:
	if not CHAP1 or not CHAP2 or not CHAP3:
		return
	if CHAP1.modulate == Color(1,1,1):
		get_tree().change_scene_to_file(CH1SCENE)
	elif CHAP2.modulate == Color(1,1,1):
		status.text = "LOCKED"
		await get_tree().create_timer(1.0).timeout
		status.text = ""
	elif CHAP3.modulate == Color(1,1,1):
		desc.text = "LOCKED"
		await get_tree().create_timer(1.0).timeout
		desc.text = ""
	else: 
		pass

func _on_mouse_entered() -> void:
	if not CHAP1 or not CHAP2 or not CHAP3:
		return
	if CHAP1.modulate == Color(1,1,1):
		title.text = "CHAPTER ONE"
		desc.text = "CHAPTER 1 DESCRIPTION"
	elif CHAP2.modulate == Color(1,1,1):
		title.text = "CHAPTER TWO"
		desc.text = "CHAPTER 2 DESCRIPTION"
	elif CHAP3.modulate == Color(1,1,1):
		title.text = "CHAPTER THREE"
		desc.text = "CHAPTER 3 DESCRIPTION"
	else: 
		pass

func _on_mouse_exited() -> void:
	if not CHAP1 or not CHAP2 or not CHAP3:
		return
	if CHAP1.modulate == Color(1,1,1):
		title.text = ""
		desc.text = ""
	elif CHAP2.modulate == Color(1,1,1):
		title.text = ""
		desc.text = ""
	elif CHAP3.modulate == Color(1,1,1):
		title.text = ""
		desc.text = ""
	else: 
		pass
