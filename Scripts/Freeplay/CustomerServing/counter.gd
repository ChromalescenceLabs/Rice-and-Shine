extends RichTextLabel
@export var rice_counter: RichTextLabel 
@export var pcake_counter: RichTextLabel
@export var hbrown_counter: RichTextLabel 
@onready var animation_player: AnimationPlayer = $"../../../AnimationPlayer"

func _on_hashbrown_cont_mouse_entered() -> void:
	animation_player.play("HbrownEntrance")

func _on_pancake_cont_mouse_entered() -> void:
	animation_player.play("PancakeEntrance")


func _on_rice_cont_mouse_entered() -> void:
	animation_player.play("RiceEntrance")




func _on_rice_cont_mouse_exited() -> void:
	animation_player.play_backwards("RiceEntrance")


func _on_pancake_cont_mouse_exited() -> void:
	animation_player.play_backwards("PancakeEntrance")


func _on_hashbrown_cont_mouse_exited() -> void:
	animation_player.play_backwards("HbrownEntrance")
