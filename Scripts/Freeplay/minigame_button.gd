extends Button
@export var label : String = "Minigame":
	set(value):
		label = value
		_update_btn_properties()
		
@export var minigame_scene : String:
	set(value):
		minigame_scene = value
		_update_btn_properties()
		
func _update_btn_properties(): self.text = label

func _ready() -> void: _update_btn_properties()

func _on_pressed() -> void: SceneLoader.load_scene(minigame_scene, 1.5)
