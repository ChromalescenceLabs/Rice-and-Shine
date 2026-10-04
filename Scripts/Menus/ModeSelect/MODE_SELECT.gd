extends Control

@export var tween_intensity: float
@export var tween_duration : float

@onready var story: TextureButton = $STORY
@onready var freeplay: TextureButton = $FREEPLAY
@onready var storytext: RichTextLabel = $STORYTEXT
@onready var freetext: RichTextLabel = $FREETEXT
@onready var modeselect: RichTextLabel = $MODESELECT

func _ready() -> void:
	storytext.visible = false
	freetext.visible = false
	modeselect.visible = true
	
func _process(_delta: float) -> void:
	btn_hovered(story)
	btn_hovered(freeplay)


func start_tween(object: Object, property: String, final_val: Variant, duration: float):
	var tween = create_tween()
	tween.tween_property(object, property,final_val, duration)

func btn_hovered(button: TextureButton):
	button.pivot_offset = button.size / 2
	if button.is_hovered():
		start_tween(button, "scale", Vector2.ONE * tween_intensity, tween_duration)
	else:
		start_tween(button, "scale", Vector2.ONE, tween_duration)

func _on_story_mouse_entered() -> void:
	storytext.visible = true


func _on_story_mouse_exited() -> void:
	storytext.visible = false

func _on_freeplay_mouse_entered() -> void:
	freetext.visible = true

func _on_freeplay_mouse_exited() -> void:
	freetext.visible = false
