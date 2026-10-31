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
			
	if not GlobalScenes.add_customer.is_connected(reparent_hapbar):
		GlobalScenes.add_customer.connect(reparent_hapbar)

func _on_show_progress_bars_pressed() -> void: progress_bars_conts_anim.play("Entrance_Exit")
func _on_close_progress_bars_pressed() -> void: progress_bars_conts_anim.play_backwards("Entrance_Exit")

func _on_tree_exiting() -> void:
	if overall_cont.get_child_count() > 0:
		for i in overall_cont.get_children():
			i.reparent(GlobalScenes.get_node("HappinessBars"))

func reparent_hapbar() -> void:
	var hapbarchildren = GlobalScenes.happiness_bars.get_children(true)
	hapbarchildren[0].reparent(overall_cont)
