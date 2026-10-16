extends Node2D
signal remove_customer(index : int)
@onready var progress_bars_conts_anim: AnimationPlayer = $ProgressBarsContsAnim
@onready var smooth_scroll_container: SmoothScrollContainer = $Control/ProgressBarsContsBG/SmoothScrollContainer
@onready var overall_cont: VBoxContainer = $Control/ProgressBarsContsBG/SmoothScrollContainer/OverallCont
const CUSTOMER_HAPPINESS_LOGS = preload("uid://dpjeqy63lxdvr")

var icon_textures : Dictionary = {
	"student" : load("uid://cbnq3e8e222c5"),
	"lolo" : load("uid://xjdoixqri3rb"),
	"marites" : load("uid://cl01be381tomn"),
	"tatay" : load("uid://dl3fu0qp4t7nq")
}

func _on_show_progress_bars_pressed() -> void: progress_bars_conts_anim.play("Entrance_Exit")
func _on_close_progress_bars_pressed() -> void: progress_bars_conts_anim.play_backwards("Entrance_Exit")

func new_happiness_bar(texture : Texture2D):
	var hapbar = CUSTOMER_HAPPINESS_LOGS.instantiate()
	hapbar.icon.texture = texture
	hapbar.upset.connect(_on_upset)
	overall_cont.add_child(hapbar)

func _on_upset(index : int) -> void:
	remove_customer.emit(index)
