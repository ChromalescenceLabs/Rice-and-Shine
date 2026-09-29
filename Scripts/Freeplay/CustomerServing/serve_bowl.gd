extends Area2D
signal contentsCheck

@onready var CheckContentsIndicator: RichTextLabel = $CheckContentsBtn
@onready var animation_player: AnimationPlayer = $AnimationPlayer
var food_entered : bool = false

var contentDict : Dictionary = {}

func _ready() -> void:
	CheckContentsIndicator.modulate.a = 0
	CheckContentsIndicator.position = Vector2(-58.093, -50)
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("RightClick"):
		contentsCheck.emit()

func _on_area_entered(area: Area2D) -> void:
	if area is FoodPickup:
		var food = str(area.texture)
		food_entered = true
		
		await area.tree_exited
		if food_entered == true:
			check_type(food)
			
			if not contentDict.has(food):
				contentDict[food] = 1
			else:
				contentDict[food] += 1

func _on_area_exited(area: Area2D) -> void:
	if area is FoodPickup and not area.is_queued_for_deletion():
		food_entered = false

func check_type(food : String):
	match food:
		"rice":
			GlobalVars.rice_value -= 1
		"pancake":
			GlobalVars.pcake_value -= 1
		"hashbrown":
			GlobalVars.hbrown_value -= 1



func _on_check_contents_btn_pressed() -> void: contentsCheck.emit()

func _on_sprite_2d_mouse_entered() -> void: 
	set_process_input(true)
	animation_player.play("Popup")
	
func _on_sprite_2d_mouse_exited() -> void: 
	set_process_input(false)
	animation_player.play_backwards("Popup")
