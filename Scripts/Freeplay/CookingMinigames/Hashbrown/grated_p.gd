extends Area2D
signal done


@onready var bowl: TextureRect = $"../bowl/bowl"
@onready var grated_p_bowl: TextureRect = $"../bowl/gratedPBowl"

var hold = false
var ogPos=position
var hasBeenPut=false
var canHold=false

func _ready() -> void:
	visible=false

func _process(_delta: float) -> void:
	if hold:
		global_position = lerp(global_position, get_global_mouse_position(), 0.2)
	else:
		global_position = lerp(global_position, ogPos, 0.05)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and canHold:
			hold = true
			visible=true
			bowl.visible=true
			grated_p_bowl.visible=false
		if not event.pressed:
			hold = false
			visible=false
			bowl.visible=false
			grated_p_bowl.visible=true
			
			if canHold:
				canHold=false
			
			if hasBeenPut==true:
				print("done")
				bowl.visible=true
				grated_p_bowl.visible=false
				done.emit()
				set_process_input(false)

func _on_bowl_mouse_entered() -> void:
	canHold=true

func _on_bowl_mouse_exited() -> void:
	canHold=false

func _on_area_entered(area: Area2D) -> void:
	if area.name=="putOnCloth":
		hasBeenPut=true
