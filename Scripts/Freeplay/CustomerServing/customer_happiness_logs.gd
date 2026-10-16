extends Node2D
@onready var progress_bars_conts_anim: AnimationPlayer = $ProgressBarsContsAnim
#@onready var progress_bars_conts_bg: ColorRect = $Control/ProgressBarsContsBG

var icon_textures : Dictionary = {
	"student" : load("uid://cbnq3e8e222c5"),
	"lolo" : load("uid://xjdoixqri3rb"),
	"marites" : load("uid://cl01be381tomn"),
	"tatay" : load("uid://dl3fu0qp4t7nq")
}

func _on_show_progress_bars_pressed() -> void: progress_bars_conts_anim.play("Entrance_Exit")
func _on_close_progress_bars_pressed() -> void: progress_bars_conts_anim.play_backwards("Entrance_Exit")


#func _on_smooth_scroll_container_mouse_entered() -> void:
	#print("smoothscroll")



func _on_progress_bars_conts_bg_mouse_entered() -> void:
	print("colorect hover")


func _on_progress_bars_conts_bg_mouse_exited() -> void:
	print("colorect unhover")
