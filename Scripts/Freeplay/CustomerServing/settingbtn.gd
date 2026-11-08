extends TextureButton
@onready var pausemenu: TabContainer = $"../PAUSEMENU"
@onready var achievemenu: PanelContainer = $"../ACHIEVEMENU"
@onready var control: Control = $".."
var visibility: bool = false

var tween: Tween

func _ready() -> void:
	pausemenu.modulate.a = 0
	pausemenu.visible = false
	visibility = false

func _on_pressed() -> void:
	if tween and tween.is_valid():
		tween.kill()
	
	tween = create_tween()
	
	if not visibility:
		if achievemenu.visible == true:
			create_tween().tween_callback(func(): achievemenu.visible = false).set_delay(0.05)
			
		pausemenu.visible = true
		tween.tween_property(pausemenu, "modulate:a", 1.0, 0.25)
		visibility = true
		get_parent().get_parent().enable_mouse()
	else:
		tween.tween_property(pausemenu, "modulate:a", 0.0, 0.25)
		tween.tween_callback(func(): pausemenu.visible = false)
		visibility = false
		get_parent().get_parent().disable_mouse()
