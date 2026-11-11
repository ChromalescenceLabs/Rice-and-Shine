extends Button
#i feel like yandev whenever i code, this feels embarassing
const LOADING_SCREEN_FADE = preload("uid://dnkgil0k2g8ap")

@onready var title_desc_container: Control = $"../../../../TitleDescContainer"
@onready var CHAP1: TextureRect = $"../HBoxContainer/ScrollContainer/ObjectContainer/CHAP1"
@onready var CHAP2: TextureRect = $"../HBoxContainer/ScrollContainer/ObjectContainer/CHAP2"
@onready var CHAP3: TextureRect = $"../HBoxContainer/ScrollContainer/ObjectContainer/CHAP3"
@onready var title: RichTextLabel = %TITLE
@onready var desc: RichTextLabel = %DESCRIPTION

@onready var status: RichTextLabel = get_node("../../../../STATUS")
@onready var hover_3: AnimationPlayer = $Hover3

const CH1SCENE = "res://Scenes/Menus/WeekSelect/week_select.tscn"

var tween: Tween

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
	hover_3.play("hover")
	if not CHAP1 or not CHAP2 or not CHAP3:
		return
		
	if tween and tween.is_running():
		tween.kill()
		
	tween = create_tween().set_parallel(true).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	
	if get_tree().current_scene.selected_indx == 0:
		title.text = "CHAPTER ONE"
		desc.text = "CHAPTER 1 DESCRIPTION"
		CHAP2.color_rect.visible = false
		tween.tween_property(CHAP2,"modulate:a",0,0.25)
		title_desc_container.reparent_to_left()
		
	elif get_tree().current_scene.selected_indx == 1:
		title.text = "CHAPTER TWO"
		desc.text = "CHAPTER 2 DESCRIPTION"
		CHAP1.color_rect.visible = false
		CHAP3.color_rect.visible = false
		tween.tween_property(CHAP1, "modulate:a",0,0.25)
		tween.tween_property(CHAP3, "modulate:a",0,0.25)
		title_desc_container.reparent_to_left()
		
	elif get_tree().current_scene.selected_indx == 2:
		title.text = "CHAPTER THREE"
		desc.text = "CHAPTER 3 DESCRIPTION"
		CHAP2.color_rect.visible = false
		tween.tween_property(CHAP2, "modulate:a",0,0.25)
		title_desc_container.reparent_to_right()

func _on_mouse_exited() -> void:
	hover_3.play_backwards("hover")
	if not CHAP1 or not CHAP2 or not CHAP3:
		return
		
	if tween and tween.is_running():
		tween.kill()

	tween = create_tween().set_parallel(true).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	
	tween.tween_property(CHAP1,"modulate:a",1.0,0.2)
	tween.tween_property(CHAP2,"modulate:a",1.0, 0.2)
	tween.tween_property(CHAP3, "modulate:a",1.0,0.2)
	CHAP1.color_rect.visible = true
	CHAP2.color_rect.visible = true
	CHAP3.color_rect.visible = true
	
	if get_tree().current_scene.selected_indx == 0:
		title_desc_container.righttoleft_backwards()
		
	elif get_tree().current_scene.selected_indx == 1:
		title_desc_container.righttoleft_backwards()
		
	elif get_tree().current_scene.selected_indx == 2:
		title_desc_container.lefttoright_backwards()


func _on_button_down() -> void: hover_3.play("play")
