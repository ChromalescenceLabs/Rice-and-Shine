extends Node2D
signal remove_customer(node: TextureButton)
const HAPPINESS_BAR = preload("uid://d1c4e3m2dk23a")

var icon_textures : Dictionary = {
	"student" : preload("uid://cbnq3e8e222c5"),
	"lolo" : preload("uid://xjdoixqri3rb"),
	"marites" : preload("uid://cl01be381tomn"),
	"tatay" : preload("uid://dl3fu0qp4t7nq")
}

func _on_upset(node : TextureButton) -> void:
	remove_customer.emit(node)

func _on_global_scenes_duplicate_customer_happiness(hapbar: HBoxContainer) -> void:
	var cloned = hapbar.duplicate(7)
	add_child(cloned)
	get_parent().add_customer.emit()
