extends Control

@export var rice_counter: RichTextLabel 
@export var pcake_counter: RichTextLabel
@export var hbrown_counter: RichTextLabel 

var rice_og_pos
var pcake_og_pos
var hbrown_og_pos

func _ready() -> void:
	
	await get_tree().process_frame 
	rice_og_pos = rice_counter.global_position
	hbrown_og_pos = hbrown_counter.global_position
	pcake_og_pos = pcake_counter.global_position

func _on_rice_cont_mouse_entered() -> void: 
	create_tween().tween_property(rice_counter, "modulate:a", 1, 0.2).set_trans(Tween.TRANS_SINE)
	create_tween().tween_property(rice_counter, "position:y", rice_og_pos.y - 10, 0.2).set_trans(Tween.TRANS_SINE)
	

func _on_rice_cont_mouse_exited() -> void:
	create_tween().tween_property(rice_counter, "modulate:a", 0, 0.2).set_trans(Tween.TRANS_SINE)
	create_tween().tween_property(rice_counter, "position", rice_og_pos, 0.2).set_trans(Tween.TRANS_SINE)


func _on_pancake_cont_mouse_entered() -> void: 
	create_tween().tween_property(pcake_counter, "modulate:a", 1, 0.2).set_trans(Tween.TRANS_SINE)
	create_tween().tween_property(pcake_counter, "position:y", pcake_og_pos.y - 10, 0.2).set_trans(Tween.TRANS_SINE)

func _on_pancake_cont_mouse_exited() -> void: 
	create_tween().tween_property(pcake_counter, "modulate:a", 0, 0.2).set_trans(Tween.TRANS_SINE)
	create_tween().tween_property(pcake_counter, "position", pcake_og_pos, 0.2).set_trans(Tween.TRANS_SINE)


func _on_hashbrown_cont_mouse_entered() -> void:
	create_tween().tween_property(hbrown_counter, "modulate:a", 1, 0.2).set_trans(Tween.TRANS_SINE)
	create_tween().tween_property(hbrown_counter, "position:y", hbrown_og_pos.y - 10, 0.2).set_trans(Tween.TRANS_SINE)

func _on_hashbrown_cont_mouse_exited() -> void: 
	create_tween().tween_property(hbrown_counter, "modulate:a", 0, 0.2).set_trans(Tween.TRANS_SINE)
	create_tween().tween_property(hbrown_counter, "position", hbrown_og_pos, 0.2).set_trans(Tween.TRANS_SINE)
