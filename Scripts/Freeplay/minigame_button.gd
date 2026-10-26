@tool
extends Button
@export var label : String = "Minigame":
	set(value):
		label = value
		_update_btn_properties()
		
@export var minigame_scene : String:
	set(value):
		minigame_scene = value
		_update_btn_properties()

@onready var animation_player: AnimationPlayer = $AnimationPlayer
	
func _update_btn_properties(): self.text = label

func _ready() -> void: _update_btn_properties()

func _on_pressed() -> void: SceneLoader.load_scene(minigame_scene, 1.5)
func _on_mouse_entered() -> void: animation_player.play("hover")
func _on_mouse_exited() -> void: animation_player.play_backwards("hover")
