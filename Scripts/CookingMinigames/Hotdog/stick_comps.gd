extends Area2D
class_name StickComps

signal dropped

@onready var mallows: Sprite2D = $Mallows
@onready var chopped_hdog: Sprite2D = $ChoppedHdog
var entered:bool = false

var type: String

func _input(event: InputEvent) -> void:
	if event.is_action_released("Click"):
		dropped.emit()

func _ready() -> void:
	match type:
		"Mallow": mallows.visible = true
		"Hotdog": chopped_hdog.visible = true

func _process(_delta: float) -> void:
	self.global_position = lerp(self.global_position, get_global_mouse_position(), 0.5)


func _on_area_entered(area: Area2D) -> void:
	if area is Stick:
		entered = true
		await dropped
		
		if entered:
			var arr_dup = area.placed.duplicate()
			arr_dup.append(type)
			area.placed = arr_dup
		
		self.queue_free()


func _on_area_exited(area: Area2D) -> void:
	if area is Stick:
		entered = false
		
