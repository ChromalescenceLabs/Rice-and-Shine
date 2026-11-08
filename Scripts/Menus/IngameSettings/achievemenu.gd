extends TextureButton
@onready var pausemenu: TabContainer = $"../PAUSEMENU"
@onready var achievemenu: PanelContainer = $"../ACHIEVEMENU"

var visibility: bool = false
var tween: Tween

func _ready() -> void:
	achievemenu.modulate.a = 0
	achievemenu.visible = false
	visibility = false

func _on_pressed() -> void:
	if tween and tween.is_valid():
		tween.kill()
	
	tween = create_tween()
	
	
	if not visibility:
		if pausemenu.visible == true:
			create_tween().tween_callback(func(): pausemenu.visible = false).set_delay(0.05)
			
		achievemenu.visible = true
		tween.tween_property(achievemenu, "modulate:a", 1.0, 0.25)
		visibility = true
	else:
		tween.tween_property(achievemenu, "modulate:a", 0.0, 0.25)
		tween.tween_callback(func(): achievemenu.visible = false)
		visibility = false
