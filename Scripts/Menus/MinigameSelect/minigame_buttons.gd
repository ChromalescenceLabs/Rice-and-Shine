extends TextureButton
@export var scene : String
@onready var minigame_select_btn_hover: Panel = $MinigameSelectBtnHover


func _ready() -> void:
	minigame_select_btn_hover.offset_transform_position = Vector2(0, 319)

func _on_pressed() -> void:
	SceneLoader.load_scene(scene, 1.5)


func _on_mouse_entered() -> void:
	minigame_select_btn_hover.animation_player.play("enter")


func _on_mouse_exited() -> void:
	minigame_select_btn_hover.animation_player.play_backwards("enter")
