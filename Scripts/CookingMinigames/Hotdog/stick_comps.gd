extends Area2D
class_name StickComps

signal dropped

@onready var mallows: Sprite2D = $Mallows
@onready var chopped_hdog: Sprite2D = $ChoppedHdog
var entered:bool = false

var type: String
var current: Stick

func _input(event: InputEvent) -> void:
	if event.is_action_released("Click"):
		dropped.emit()
		
		if current and entered:
			set_process(false)
			set_process_input(false)
			var arr_dup = current.placed.duplicate()
			arr_dup.append(type)
			current.placed = arr_dup
			get_parent().amt -= 1
			
			self.global_position = current.global_position
			self.global_position.y = current.global_position.y + (100 * get_parent().amt)
			
			current = null 
		else:
			self.queue_free()

func _ready() -> void:
	match type:
		"Mallow": mallows.visible = true
		"Hotdog": chopped_hdog.visible = true

func _process(_delta: float) -> void:
	self.global_position = lerp(self.global_position, get_global_mouse_position(), 0.5)

func _on_area_entered(area: Area2D) -> void:
	if area is Stick:
		entered = true
		current = area

func _on_area_exited(area: Area2D) -> void:
	if area is Stick:
		entered = false
		current = null

func _on_dropped() -> void:
	if not entered:
		self.queue_free()
