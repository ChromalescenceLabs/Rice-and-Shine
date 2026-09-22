extends Button


func _ready() -> void:
	var tween = create_tween()
	
	tween.tween_property(Button,"position", Vector2(0,-100), 1)

 
