extends Control
@onready var animation_player: AnimationPlayer = $CanvasLayer/ZoomCam/AnimationPlayer
@onready var story_button_anim: AnimationPlayer = $Node2D/Parallax2D2/STORY/StoryButtonAnim
@onready var freeplay_button_anim: AnimationPlayer = $Node2D/Parallax2D2/FREEPLAY/FreeplayButtonAnim

var Anim: bool = false

func _on_story_mouse_entered() -> void: 
	story_button_anim.play("hover")
func _on_story_mouse_exited() -> void:
	story_button_anim.play_backwards("hover")

func _on_freeplay_mouse_entered() -> void: 
	freeplay_button_anim.play("hover")
func _on_freeplay_mouse_exited() -> void: 
	freeplay_button_anim.play_backwards("hover")
