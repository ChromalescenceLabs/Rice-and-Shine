extends Button
#i feel like yandev whenever i code, this feels embarassing
const LOADING_SCREEN_FADE = preload("uid://dnkgil0k2g8ap")

@export var CHAP1: CanvasItem
@export var CHAP2: CanvasItem
@export var CHAP3: CanvasItem

@onready var title: RichTextLabel = get_node("../../../../TITLE")
@onready var status: RichTextLabel = get_node("../../../../STATUS")
@onready var desc: RichTextLabel = get_node("../../../../DESCRIPTION")

const CH1SCENE = "uid://benuikw1v40e"

var tween: Tween

func _ready() -> void: 
	title.position = Vector2(450,234)
	desc.position = Vector2(450,303)

func _on_pressed() -> void:
	if not CHAP1 or not CHAP2 or not CHAP3:
		return
	if CHAP1.modulate == Color(1,1,1):
		SceneLoader.load_scene(CH1SCENE, 1.5, LOADING_SCREEN_FADE)
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
		
	if tween and tween.is_running():
		tween.kill()
		
	tween = create_tween().set_parallel(true).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	
	if CHAP1.modulate == Color(1,1,1):
		title.text = "CHAPTER ONE"
		desc.text = "CHAPTER 1 DESCRIPTION"
		tween.tween_property(CHAP2,"modulate:a",0,0.25)
		tween.tween_property(title, "position",Vector2(694,234),0.25)
		tween.tween_property(desc, "position",Vector2(694,303),0.25)
		
	elif CHAP2.modulate == Color(1,1,1):
		title.text = "CHAPTER TWO"
		desc.text = "CHAPTER 2 DESCRIPTION"
		tween.tween_property(CHAP1, "modulate:a",0,0.25)
		tween.tween_property(CHAP3, "modulate:a",0,0.25)
		tween.tween_property(title, "position",Vector2(694,234),0.25)
		tween.tween_property(desc, "position",Vector2(694,303),0.25)
		
	elif CHAP3.modulate == Color(1,1,1):
		title.text = "CHAPTER THREE"
		desc.text = "CHAPTER 3 DESCRIPTION"
		tween.tween_property(CHAP2, "modulate:a",0,0.25)
		tween.tween_property(title, "position",Vector2(196,234),0.25)
		tween.tween_property(desc, "position",Vector2(196,303),0.25)
	else: 
		pass

func _on_mouse_exited() -> void:
	if not CHAP1 or not CHAP2 or not CHAP3:
		return
	title.text = ""
	desc.text = ""
	
	if tween and tween.is_running():
		tween.kill()
		
	tween = create_tween().set_parallel(true).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	tween.tween_property(CHAP1,"modulate:a",1.0,0.2)
	tween.tween_property(CHAP2,"modulate:a",1.0, 0.2)
	tween.tween_property(CHAP3, "modulate:a",1.0,0.2)
	
	title.position = Vector2(450,234)
	desc.position = Vector2(450,303)
