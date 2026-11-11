extends Control
@onready var v_box_container: VBoxContainer = $LeftPos/VBoxContainer
@onready var v_box_container_2: VBoxContainer = $RightPos/VBoxContainer2
@onready var title: RichTextLabel = %TITLE
@onready var description: RichTextLabel = %DESCRIPTION
@onready var status: RichTextLabel = %STATUS

var tween: Tween

func reparent_to_left() -> void: 
	description.reparent(v_box_container_2)
	title.reparent(v_box_container_2)
	status.reparent(v_box_container_2)
	v_box_container_2.move_child(description, 1)
	v_box_container_2.move_child(title, 1)
	v_box_container_2.move_child(status, 4)
	
	# Reset Values
	description.modulate.a = 0
	title.modulate.a = 0
	description.offset_transform_position_ratio.x = 1.07
	title.offset_transform_position_ratio.x = 1.07
	
	if tween and tween.is_running(): tween.kill()
	tween = create_tween().set_parallel(true).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	
	# Animation
	tween.tween_property(description, "modulate:a", 1, 0.3).set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(title, "modulate:a", 1, 0.3).set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(description, "offset_transform_position_ratio:x", 0, 0.5).set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(title, "offset_transform_position_ratio:x", 0, 0.5).set_trans(Tween.TRANS_CUBIC)

func reparent_to_right() -> void: 
	description.reparent(v_box_container)
	title.reparent(v_box_container)
	status.reparent(v_box_container)
	v_box_container.move_child(description, 1)
	v_box_container.move_child(title, 1)
	v_box_container.move_child(status, 4)
	
	# Reset Values
	description.modulate.a = 0
	title.modulate.a = 0
	description.offset_transform_position_ratio.x = -1.05
	title.offset_transform_position_ratio.x = -1.05
	
	if tween and tween.is_running(): tween.kill()
	tween = create_tween().set_parallel(true).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	
	# Animation
	tween.tween_property(description, "modulate:a", 1, 0.3).set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(title, "modulate:a", 1, 0.3).set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(description, "offset_transform_position_ratio:x", 0, 0.5).set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(title, "offset_transform_position_ratio:x", 0, 0.5).set_trans(Tween.TRANS_CUBIC)

func lefttoright_backwards() -> void:
	if tween and tween.is_running(): tween.kill()
	tween = create_tween().set_parallel(true).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	tween.tween_property(description, "modulate:a", 0, 0.3).set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(title, "modulate:a", 0, 0.3).set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(description, "offset_transform_position_ratio:x", 1.07, 0.5).set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(title, "offset_transform_position_ratio:x", 1.07, 0.5).set_trans(Tween.TRANS_CUBIC)
	
func righttoleft_backwards() -> void:
	if tween and tween.is_running(): tween.kill()
	tween = create_tween().set_parallel(true).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	tween.tween_property(description, "modulate:a", 0, 0.3).set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(title, "modulate:a", 0, 0.3).set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(description, "offset_transform_position_ratio:x", -1.05, 0.5).set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(title, "offset_transform_position_ratio:x", -1.05, 0.5).set_trans(Tween.TRANS_CUBIC)
	
