extends Control
signal contentsCheck

const BOWL_CONTENTS_LABEL = preload("uid://ye58mwdno13d")

@onready var bowl_conts: HBoxContainer = $".."
@onready var CheckContentsIndicator: RichTextLabel = $CheckContentsBtn
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var freed_bowls : Control = $"../../FreedBowls"
@onready var check_contents_btn: RichTextLabel = $CheckContentsBtn
var food_entered : bool = false
var contents_shown : bool = false
var popped_up : bool = false
var final_pos 
var node_ready : bool = false

var contentDict : Dictionary = {}

func _ready() -> void:
	set_process_input(false)
	check_contents_btn.modulate.a = 0
	self.mouse_filter = Control.MOUSE_FILTER_IGNORE
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("RightClick"):
		contentsCheck.emit()

func _on_contents_check() -> void:
	if not node_ready:
		return
	
	contents_shown = true
	var contentLabel = BOWL_CONTENTS_LABEL.instantiate()
	contentLabel.content_dict = contentDict
	contentLabel.global_position = self.global_position
	contentLabel.global_position.x = self.global_position.x + self.size.x/2
	get_tree().current_scene.bowl_labels.add_child(contentLabel)
	
	await contentLabel.tree_exited
	contents_shown = false


func _on_area_2d_area_entered(area: Area2D) -> void:
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

func _on_area_2d_area_exited(area: Area2D) -> void:
	if area is FoodPickup and not area.is_queued_for_deletion():
		food_entered = false


func _on_mouse_entered() -> void:
	if not contents_shown:
		set_process_input(true)
		animation_player.play("Popup")
		popped_up = true

func _on_mouse_exited() -> void:
		set_process_input(false)
		if popped_up:
			animation_player.play_backwards("Popup")
			popped_up = false

func initialization():
	if not self.is_in_group("ClonedBowls"):	
		final_pos = self.global_position
		
		var dupli = self.duplicate(11)
		dupli.set_script(null)
		dupli.modulate.a = 0
		dupli.add_to_group("ClonedBowls")
		
		bowl_conts.add_child(dupli)
		
		var last_index := bowl_conts.get_child_count() - 1
		bowl_conts.move_child(dupli, max(0, last_index - 1))
		
		self.reparent(freed_bowls)
		self.global_position = Vector2(1280, final_pos.y) + Vector2(self.size.x, 0)
		
		self.modulate.a = 1.0
		var tw = create_tween().tween_property(self, "global_position:x", final_pos.x, 0.5).set_trans(Tween.TRANS_CUBIC)
		self.mouse_filter = Control.MOUSE_FILTER_PASS
		
		await tw.finished
		node_ready = true
