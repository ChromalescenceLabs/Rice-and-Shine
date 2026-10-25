extends Node2D
signal done

@onready var cloth: Area2D = $putOnCloth
@onready var scroll_1: Node2D = $scroll1
@onready var scroll_2: Node2D = $scroll2
@onready var squeezing: Node2D = $squeezing

var pulledNum=0

func scrollIn(scroll):
	var origPos=scroll.position.x
	scroll.position.x += 100
	scroll.modulate.a=0
	scroll.visible=true
	var tween= create_tween()
	tween.tween_property(scroll, "position:x", origPos, 2).set_trans(Tween.TRANS_ELASTIC)
	tween.parallel().tween_property(scroll, "modulate:a", 1, 2).set_trans(Tween.TRANS_EXPO)

func scrollOut(scroll):
	var newPos= scroll.position.x + 100
	scroll.visible=true
	var tween= create_tween()
	tween.tween_property(scroll, "position:x", newPos, 2).set_trans(Tween.TRANS_ELASTIC)
	tween.parallel().tween_property(scroll, "modulate:a", 0, 2).set_trans(Tween.TRANS_EXPO)

func hideAndView(h,v):
	var t = create_tween()
	t.tween_property(h, "position:y", h.position.y-50, 1.0).set_trans(Tween.TRANS_EXPO)
	await get_tree().create_timer(.5).timeout
	t.stop()
	h.visible=false
	v.visible=true
	t = create_tween()
	t.tween_property(v, "position:y", v.position.y+20, .5).set_trans(Tween.TRANS_ELASTIC)
	await t.finished
	if pulledNum==2:
		done.emit()

func _on_grated_p_done() -> void:
	cloth.get_child(0).visible=false
	cloth.get_child(1).visible=true
	scrollIn(scroll_1)

func _on_knob_pulled() -> void:
	var uSqueezed = squeezing.get_child(0)
	var squeezed = squeezing.get_child(1)
	print(pulledNum)
	if pulledNum==0:
		hideAndView(cloth, uSqueezed)
		scrollOut(scroll_1)
		scrollIn(scroll_2)
		await get_tree().create_timer(1).timeout
	elif pulledNum==1:
		hideAndView(uSqueezed, squeezed)
		scrollOut(scroll_2)

func _on_unsqueezed_visibility_changed() -> void:
	pulledNum+=1
