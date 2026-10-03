extends Area2D

@onready var gratedp: Control = $"../gratedRemains"
@onready var grater: Area2D = $"../grater"
@onready var animation_player: AnimationPlayer = $"../grater/AnimationPlayer"

signal grated

var origPos
var picked=false
var canGrate=false 
var amtChange =-1
var dropped=false
var start=false
var current_velocity

func _ready() -> void:
	GlobalVars.itemEntered.connect(itemEntered)

func grate(amt:int):
	var first = amt * 2
	var subset = self.get_children().slice(first, first+2)
	for child in subset:
		#First 2 child becomes invis
		print(">", child.name)
		child.visible= false
	subset = self.get_children().slice(first+2, first+4)
	for child in subset:
		#last 2 becomes vis
		print(">", child.name)
		child.visible= true
	
	if amtChange==3:
		grated.emit()
	elif amtChange<3:
		gratedp.get_child(amt).visible=true
		gratedp.get_child(amt-1).visible=false

func _process(_delta: float) -> void:
	if picked:
		global_position = lerp(global_position, get_global_mouse_position(), 0.2)
	elif start:
		global_position = lerp(global_position, origPos, 0.05)

func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	#yup thanks jhaz
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			picked = true
			if not event.pressed:
				picked = false

#change
func _on_area_entered(area: Area2D) -> void:
	if area.name == "grater":
		canGrate=true

#change when out
func _on_area_exited(area: Area2D) -> void:
	if area.name == "grater":
		canGrate=false
		current_velocity = Input.get_last_mouse_velocity().x
		if abs(current_velocity) > 1000 and picked:
			amtChange+=1
			grate(amtChange)
			animation_player.play("grate")
			await animation_player.animation_finished
			print(amtChange)

func itemEntered(item):
	if item.name=="grate":
		start=true
		origPos = Vector2(1022.0, 379.0)
		print(amtChange)
