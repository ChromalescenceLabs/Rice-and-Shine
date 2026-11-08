extends Button
#i feel like yandev whenever i code, this feels embarassing
const LOADING_SCREEN_FADE = preload("uid://dnkgil0k2g8ap")

@onready var CHAP1: TextureRect = $"../HBoxContainer/ScrollContainer/ObjectContainer/CHAP1"
@onready var CHAP2: TextureRect = $"../HBoxContainer/ScrollContainer/ObjectContainer/CHAP2"
@onready var CHAP3: TextureRect = $"../HBoxContainer/ScrollContainer/ObjectContainer/CHAP3"

@onready var title: RichTextLabel = get_node("../../../../TITLE")
@onready var status: RichTextLabel = get_node("../../../../STATUS")
@onready var desc: RichTextLabel = get_node("../../../../DESCRIPTION")

const CH1SCENE = "res://Scenes/Menus/WeekSelect/week_select.tscn"

var tween: Tween

func _ready() -> void: 
	title.position = Vector2(450,234)
	desc.position = Vector2(450,303)

func _on_pressed() -> void:
	if not CHAP1 or not CHAP2 or not CHAP3:
		return
	if get_tree().current_scene.selected_indx == 0:
		SceneLoader.load_scene(CH1SCENE, 1.5, LOADING_SCREEN_FADE)
	elif get_tree().current_scene.selected_indx == 1:
		status.text = "LOCKED"
		await get_tree().create_timer(1.0).timeout
		status.text = ""
	elif CHAP3.modulate == Color(1,1,1):
		status.text = "LOCKED"
		await get_tree().create_timer(1.0).timeout
		status.text = ""
	else: 
		pass

func _on_mouse_entered() -> void:
	if not CHAP1 or not CHAP2 or not CHAP3:
		return
		
	if tween and tween.is_running():
		tween.kill()
		
	tween = create_tween().set_parallel(true).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	
	print(get_tree().current_scene.selected_indx)
	if get_tree().current_scene.selected_indx == 0:
		title.text = "CHAPTER ONE"
		desc.text = "CHAPTER 1 DESCRIPTION"
		tween.tween_property(CHAP2,"modulate:a",0,0.25)
		tween.tween_property(title, "position",Vector2(650,234),0.25)
		tween.tween_property(desc, "position",Vector2(650,303),0.25)
		
	elif get_tree().current_scene.selected_indx == 1:
		title.text = "CHAPTER TWO"
		desc.text = "CHAPTER 2 DESCRIPTION"
		tween.tween_property(CHAP1, "modulate:a",0,0.25)
		tween.tween_property(CHAP3, "modulate:a",0,0.25)
		tween.tween_property(title, "position",Vector2(650,234),0.25)
		tween.tween_property(desc, "position",Vector2(650,303),0.25)
		
	elif get_tree().current_scene.selected_indx == 2:
		title.text = "CHAPTER THREE"
		desc.text = "CHAPTER 3 DESCRIPTION"
		tween.tween_property(CHAP2, "modulate:a",0,0.25)
		tween.tween_property(title, "position",Vector2(250,234),0.25)
		tween.tween_property(desc, "position",Vector2(250,303),0.25)

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
