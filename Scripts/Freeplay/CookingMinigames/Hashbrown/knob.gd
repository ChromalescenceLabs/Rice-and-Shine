extends Area2D

@onready var end: Area2D = $"../end"
@onready var squeezing: Node2D = $"../../squeezing"
@onready var cloth: Area2D = $"../../putOnCloth"

var hold = false
var ogPos=position
var canHold=false
var scrolledNum=0

func _process(_delta: float) -> void:
	var mouse=get_local_mouse_position().y+position.y
	if hold and mouse<ogPos.y and mouse>end.position.y:
		position.y = lerp(position.y, mouse, 0.2)
	else:
		position.y = lerp(position.y, ogPos.y, 0.05)

func _on_area_entered(area: Area2D) -> void:
	var uSqueezed = squeezing.get_child(0)
	var squeezed = squeezing.get_child(1)
	if area.name=="end":
		ogPos=area.position
		set_process_input(false)
		
		if scrolledNum==0:
			hideAndView(cloth,uSqueezed)
			scrolledNum+=1
		elif scrolledNum==1:
			hideAndView(uSqueezed,squeezed)
		print(scrolledNum)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and canHold:
			hold = true
		if not event.pressed:
			hold = false
			if canHold:
				canHold=false

func _on_start_mouse_entered() -> void:
	canHold=true

func _on_start_mouse_exited() -> void:
	canHold=false

func hideAndView(h,v):
	var t = create_tween()
	t.tween_property(h, "position:y", h.position.y-50, 1.0).set_trans(Tween.TRANS_EXPO)
	await get_tree().create_timer(.5).timeout
	t.stop()
	h.visible=false
	v.visible=true
	t = create_tween()
	t.tween_property(v, "position:y", v.position.y+20, .5).set_trans(Tween.TRANS_ELASTIC)
