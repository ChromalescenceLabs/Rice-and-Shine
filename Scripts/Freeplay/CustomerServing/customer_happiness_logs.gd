extends Node2D
signal remove_customer(index : int)
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

func _on_show_progress_bars_pressed() -> void: progress_bars_conts_anim.play("Entrance_Exit")
func _on_close_progress_bars_pressed() -> void: progress_bars_conts_anim.play_backwards("Entrance_Exit")

func new_happiness_bar(texture : String, time : float = 0):
	await get_tree().create_timer(1 - time).timeout
	var hapbar = HAPPINESS_BAR.instantiate()
	hapbar.upset.connect(_on_upset)
	overall_cont.add_child(hapbar)
	hapbar.icon.texture = icon_textures[texture]
	hapbar.type = texture
	
	return hapbar

func _on_upset(index : int) -> void:
	remove_customer.emit(index)
