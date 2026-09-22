extends Control
@onready var closed: TextureRect = $Closed
@onready var open: TextureRect = $Opened/Open
@onready var opened: Control = $Opened
@onready var instructions: RichTextLabel = $Opened/Instructions
@onready var ins_anim_in: AnimationPlayer = $Opened/InsAnimIn
@onready var intro_anim: AnimationPlayer = $IntroAnim

func _ready() -> void:
	closed.visible = true
	ins_anim_in.play("fade")
	intro_anim.play("Intro")
	
	GlobalVars.instructions_changed.connect(_on_instructions_changed)

func _on_closed_mouse_entered() -> void:
	opened.visible = true
	closed.visible = false

func _on_open_mouse_exited() -> void:
	closed.visible = true
	opened.visible = false

func _on_instructions_changed(value):
	ins_anim_in.play_backwards("fade")
	instructions.text = value
	ins_anim_in.play("fade")
