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
	if area.name=="end":
		ogPos=area.position
		set_process_input(false)
		
		if scrolledNum==0:
			var t = create_tween()
			var uSqueezed = squeezing.get_child(0)
			t.tween_property(cloth, "position:y", cloth.position.y-50, 1.0).set_trans(Tween.TRANS_EXPO)
			await get_tree().create_timer(.5).timeout
			t.stop()
			cloth.visible=false
			uSqueezed.visible=true
			t.play()
			t.tween_property(uSqueezed, "position:y", uSqueezed.position.y+20, 1.0).set_trans(Tween.TRANS_CUBIC)
		scrolledNum+=1

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
