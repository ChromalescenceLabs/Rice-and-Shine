extends Node2D
class_name Trashbin
@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_parent() is Bowl:
		animation_player.play("TrashAnim")

func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.get_parent() is Bowl:
		animation_player.play_backwards("TrashAnim")
