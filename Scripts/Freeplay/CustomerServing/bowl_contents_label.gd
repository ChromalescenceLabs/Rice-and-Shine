extends Node2D
@onready var contents_bg: ColorRect = $Control/ContentsBG
@onready var content_list: VBoxContainer = $Control/SmoothScrollContainer/ContentList
@onready var control: Control = $Control

var og_pos
var content_dict : Dictionary 

func _physics_process(delta: float) -> void:
	print(is_processing_input())

func _ready() -> void:
	for i in content_dict:
		var hbox = HBoxContainer.new()
		var food = TextureRect.new()
		var qty = RichTextLabel.new()
		
		food.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		qty.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		qty.fit_content = true
		qty.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
		qty.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
		food.texture = i
		qty.text = str(content_dict[i])
		hbox.size_flags_vertical = Control.SIZE_FILL
		hbox.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		hbox.alignment = BoxContainer.ALIGNMENT_CENTER
		content_list.add_child(hbox)
		hbox.add_child(food)
		hbox.add_child(qty)
		
	self.modulate.a = 0
	control.mouse_filter = Control.MOUSE_FILTER_IGNORE
	set_process_input(false)
	og_pos = self.position.y
	var tw = create_tween().tween_property(self, "position:y", self.position.y - contents_bg.size.y, 0.5).set_trans(Tween.TRANS_CUBIC)
	create_tween().tween_property(self, "modulate:a", 1, 0.5).set_trans(Tween.TRANS_CUBIC)
	
	await tw.finished
	set_process_input(true)
	control.mouse_filter = Control.MOUSE_FILTER_PASS

func _input(_event: InputEvent) -> void:
	if Input.is_anything_pressed():
		set_process_input(false)
		var tw = create_tween().tween_property(self, "position:y", og_pos, 0.5).set_trans(Tween.TRANS_CUBIC)
		create_tween().tween_property(self, "modulate:a", 0, 0.5).set_trans(Tween.TRANS_CUBIC)
		await tw.finished
		
		self.queue_free()

func _on_control_mouse_entered() -> void: 
	set_process_input(false)
	
func _on_control_mouse_exited() -> void:
	set_process_input(true)
