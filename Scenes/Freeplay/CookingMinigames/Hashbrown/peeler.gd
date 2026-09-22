extends Area2D

var areas:int = 33
var areas_checked:int = 0

func _process(delta: float) -> void:
	if areas_checked == areas:
		get_parent().peeled.emit()
		set_process(false)


func _on_area_entered(area: Area2D) -> void:
	if area is peel_area_checker and area.checked == false:
		area.checked = true
		areas_checked += 1
		
func _on_area_exited(_area: Area2D) -> void:
	pass
