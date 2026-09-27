extends Control
@onready var closed: TextureRect = $Closed
@onready var open: TextureRect = $Opened/Open
@onready var opened: Control = $Opened
@onready var instructions: RichTextLabel = $Opened/Instructions
@onready var instructions_2: RichTextLabel = $Opened/Instructions2
@onready var ins_anim_in: AnimationPlayer = $Opened/InsAnimIn
@onready var intro_anim: AnimationPlayer = $IntroAnim

func _ready() -> void:
	closed.visible = true
	opened.visible = false
	ins_anim_in.play("fade")
	intro_anim.play("Intro")
	
	GlobalVars.instructions_changed.connect(_on_instructions_changed)

func _on_closed_mouse_entered() -> void:
	ins_anim_in.play("fade")
	opened.visible = true
	closed.visible = false

func _on_opened_mouse_exited() -> void:
	closed.visible = true
	opened.visible = false

func _on_instructions_changed(item):
	ins_anim_in.play_backwards("fade")
	if item.name.to_lower()=="ricecups":
		instructions.text = "insert ur shit here"
		instructions_2.text = "augh"

	elif item.name.to_lower() == "water":
		instructions.text = "Ingredients: water"
		instructions_2.text = "you"
	ins_anim_in.play("fade")
