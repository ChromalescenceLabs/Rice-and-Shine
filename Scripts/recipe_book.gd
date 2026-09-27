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
		
	
	# HOTDOG SECTION
	
	elif item.name.to_lower() == "slicing":
		instructions.text = "STEP 1: Create cuts on the hotdog."
		instructions_2.text = "This allows the hotdog to be cooked thoroughly."
		
	elif item.name.to_lower() == "frying":
		instructions.text = "STEP 2: Pour oil in the pan and cook the cut hotdogs."
		instructions_2.text = "Generally, this is already a good meal, but we can do better."
		
	elif item.name.to_lower() == "chopping":	
		instructions.text = "STEP 3: Chop the hotdogs into tinier pieces."
		instructions_2.text = "This is to be used in pair with marshmallows."
		
	elif item.name.to_lower() == "stick":
		instructions.text = "STEP 4: Place the marshmallows and hotdog pieces onto the stick."
		instructions_2.text = "And you will have your hotdog and marshmallows on a stick!"
	ins_anim_in.play("fade")
