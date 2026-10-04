extends TextureButton


func _on_pressed() -> void: 
	await get_tree().create_timer(1.0).timeout
	SceneLoader.load_scene("uid://f5bkmxvr0cpx", 2)
