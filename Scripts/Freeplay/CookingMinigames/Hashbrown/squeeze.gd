extends Node2D

@onready var put_on_cloth: Area2D = $putOnCloth
@onready var scroll_1: Node2D = $scroll1

func scrollIn(scroll):
	scroll.position.x += get_viewport().get_visible_rect().size.x
	scroll.visible=true
	scroll.scale=Vector2(0,0)
	var tw = create_tween()
	tw.tween_property(scroll, "position", Vector2(0,0), 2).set_trans(Tween.TRANS_ELASTIC)
	tw.tween_property(scroll, "scale", Vector2(1,1), 0.3).set_trans(Tween.TRANS_BOUNCE)
	await tw.finished


func _on_grated_p_done() -> void:
	put_on_cloth.get_child(0).visible=false
	put_on_cloth.get_child(1).visible=true
	scrollIn(scroll_1)
