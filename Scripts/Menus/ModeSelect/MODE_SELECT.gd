extends Control

@export var tween_intensity: float
@export var tween_duration : float

@onready var story: TextureButton = $STORY
@onready var freeplay: TextureButton = $FREEPLAY
@onready var storytext: RichTextLabel = $STORYTEXT
@onready var freetext: RichTextLabel = $FREETEXT
@onready var modeselect: RichTextLabel = $MODESELECT

var Anim: bool = false

func _ready() -> void:
	storytext.visible = false
	freetext.visible = false
	modeselect.visible = true
	story.pivot_offset = story.size / 2
	freeplay.pivot_offset = freeplay.size / 2
	
func start_tween(object: Object, property: String, final_val: Variant, duration: float):
	var tween = create_tween()
	tween.set_trans(tween.TRANS_CUBIC)
	tween.set_ease(tween.EASE_OUT)
	tween.tween_property(object, property,final_val, duration)

func _on_story_mouse_entered() -> void:
	storytext.visible = true
	if Anim == false:
		start_tween(story, "scale",Vector2.ONE *  tween_intensity, tween_duration)

func _on_story_mouse_exited() -> void:
	storytext.visible = false
	if Anim == false:
		start_tween(story, "scale", Vector2.ONE, tween_duration)

func _on_freeplay_mouse_entered() -> void:
	freetext.visible = true
	if Anim == false:
		start_tween(freeplay, "scale",Vector2.ONE *  tween_intensity, tween_duration)
	
func _on_freeplay_mouse_exited() -> void:
	freetext.visible = false
	if Anim == false:
		start_tween(freeplay, "scale", Vector2.ONE, tween_duration)

func _on_modeanim_current_animation_changed(anim_name: StringName) -> void:
	if anim_name == "FREEPLAY" or anim_name == "STORY":
		Anim = true
		print("Animation started")
