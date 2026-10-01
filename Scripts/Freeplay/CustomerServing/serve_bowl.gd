extends Area2D
signal contentsCheck

const BOWL_CONTENTS_LABEL = preload("uid://ye58mwdno13d")

@onready var CheckContentsIndicator: RichTextLabel = $CheckContentsBtn
@onready var animation_player: AnimationPlayer = $AnimationPlayer
var food_entered : bool = false
var contents_shown : bool = false
var popped_up : bool = false

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
		var texture
		food_entered = true
		
		await area.tree_exited
		if food_entered == true:
			match food:
				"rice":
					texture = preload("uid://c46do5q6bcopm")
					GlobalVars.rice_value -= 1
				"pancake":
					texture = preload("uid://bu18d5et72sre")
					GlobalVars.pcake_value -= 1
				"hashbrown":
					texture = preload("uid://be4y7ewpqycrh")
					GlobalVars.hbrown_value -= 1
			
			if not contentDict.has(texture):
				contentDict[texture] = 1
			else:
				contentDict[texture] += 1

func _on_area_exited(area: Area2D) -> void:
	if area is FoodPickup and not area.is_queued_for_deletion():
		food_entered = false



func _on_check_contents_btn_pressed() -> void: contentsCheck.emit()

func _on_sprite_2d_mouse_entered() -> void: 
	if not contents_shown:
		set_process_input(true)
		animation_player.play("Popup")
		popped_up = true
	
func _on_sprite_2d_mouse_exited() -> void: 
		set_process_input(false)
		if popped_up:
			animation_player.play_backwards("Popup")
			popped_up = false


func _on_contents_check() -> void:
	contents_shown = true
	var contentLabel = BOWL_CONTENTS_LABEL.instantiate()
	contentLabel.position = self.position
	contentLabel.content_dict = contentDict
	get_tree().current_scene.bowl_labels.add_child(contentLabel)
	
	await contentLabel.tree_exited
	contents_shown = false
