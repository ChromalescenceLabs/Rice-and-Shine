extends Area2D
var areas:int = 34
var areas_checked:int = 0

func _process(_delta: float) -> void:
	if areas_checked == areas:
		get_parent().get_parent().peeled.emit()
		set_process(false)


func _on_area_entered(area: Area2D) -> void:
	if area is peel_area_checker and not area.checked:
		area.checked = true
		areas_checked += 1
		print(areas_checked)
		
func _on_area_exited(_area: Area2D) -> void:
	pass
