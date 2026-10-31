extends Node2D
signal remove_customer(index : int, node : TextureButton)
@onready var progress_bars_conts_anim: AnimationPlayer = $ProgressBarsContsAnim
@onready var smooth_scroll_container: SmoothScrollContainer = $Control/ProgressBarsContsBG/SmoothScrollContainer
@onready var overall_cont: VBoxContainer = $Control/ProgressBarsContsBG/SmoothScrollContainer/OverallCont
const HAPPINESS_BAR = preload("uid://d1c4e3m2dk23a")

var icon_textures : Dictionary = {
	"student" : preload("uid://cbnq3e8e222c5"),
	"lolo" : preload("uid://xjdoixqri3rb"),
	"marites" : preload("uid://cl01be381tomn"),
	"tatay" : preload("uid://dl3fu0qp4t7nq")
}

func _ready() -> void:
	if GlobalScenes.get_node("HappinessBars").get_child_count() > 0:
		for i in GlobalScenes.get_node("HappinessBars").get_children():
			i.reparent(overall_cont)
			i.upset.connect(_on_upset)

func _on_show_progress_bars_pressed() -> void: progress_bars_conts_anim.play("Entrance_Exit")
func _on_close_progress_bars_pressed() -> void: progress_bars_conts_anim.play_backwards("Entrance_Exit")

func new_happiness_bar(texture : String, node : TextureButton):
	var hapbar = HAPPINESS_BAR.instantiate()
	overall_cont.add_child(hapbar)
	hapbar.upset.connect(_on_upset)
	hapbar.icon.texture = icon_textures[texture]
	hapbar.type = texture
	hapbar.associated_node = node
	
	return hapbar

func _on_upset(index : int, node : TextureButton) -> void:
	remove_customer.emit(index, node)

func _on_tree_exiting() -> void:
	if overall_cont.get_child_count() > 0:
		for i in overall_cont.get_children():
			i.reparent(GlobalScenes.get_node("HappinessBars"))

func _on_remove_customer(index: int, node: TextureButton) -> void:
	if GlobalScenes.get_node("Customers").get_child_count():
		for i in GlobalScenes.get_node("Customers").get_children():
			if i == node:
				i.queue_free()
