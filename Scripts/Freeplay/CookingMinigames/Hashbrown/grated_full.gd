extends Area2D
@onready var peeled: TextureRect = $Peeled

var origPos
var picked=false
var canGrate=false 
var amtChange =-1
var dropped=false
var start=false

func _ready() -> void:
	GlobalVars.itemEntered.connect(_itemEntered)

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

func _process(_delta: float) -> void:
	if picked:
		global_position = lerp(global_position, get_global_mouse_position(), 0.2)
	elif start:
		global_position = lerp(global_position, origPos, 0.05)

func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed("Click"):
		picked=true
	
	if event.is_action_released("Click"):
		picked=false

func _on_area_entered(area: Area2D) -> void:
	if area.name == "grater":
		canGrate=true

func _on_area_exited(area: Area2D) -> void:
	if area.name == "grater":
		canGrate=false
		if not picked:
			amtChange+=1
			grate(amtChange)
			print(amtChange)

func _itemEntered():
	start=true
	origPos = global_position
	print(amtChange)
