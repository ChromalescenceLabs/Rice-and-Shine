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
	
	GlobalVars.itemEntered.connect(itemEntered)

func _on_closed_mouse_entered() -> void:
	ins_anim_in.play("fade")
	opened.visible = true
	closed.visible = false

func _on_opened_mouse_exited() -> void:
	closed.visible = true
	opened.visible = false

func itemEntered(item):
	#note prefix all names to the scene itself
	
	ins_anim_in.play_backwards("fade")
	if item.name.to_lower()=="ricecups":
		instructions.text = "insert ur shit here"
		instructions_2.text = "augh"

	elif item.name.to_lower() == "water":
		instructions.text = "Ingredients: water"
		instructions_2.text = "you"
		
	# HOTDOG INSTRUCTIONS
	elif item.name.to_lower() == "slicing":
		instructions.text = "Create small cuts or slits in the surface of the hotdogs."
		instructions_2.text = "This is to ensure that the inside of the hotdog also gets cooked."
	elif item.name.to_lower() == "frying":
		instructions.text = "Place oil in the pan and begin frying the hotdog until it reaches a nice dark color."
		instructions_2.text = ""
	elif item.name.to_lower() == "chopping":
		instructions.text = "Proceed to chop the hotdogs into smaller pieces."
		instructions_2.text = ""
	elif item.name.to_lower() == "stick":
		instructions.text = "Place the hotdogs and marshmallows on the stick."
		instructions_2.text = "Usually done in an alternating pattern."
	
	
	# INIHAW INSTRUCTIONS
	elif item.name.to_lower() == "inihaw_chopping":
		instructions.text = "Slice the pork into smaller pieces."
		instructions_2.text = ""
	elif item.name.to_lower() == "mincing":
		instructions.text = "Mince the garlic by slicing it a bunch of times."
		instructions_2.text = ""
	elif item.name.to_lower() == "prepping":
		instructions.text = "Prepare the marinade of the inihaw."
		instructions_2.text = "Ingredients include soy sauce, calamansi juice, banana ketchup, brown sugar, garlic, black pepper, and sprite."
	
	
	# TORTA INSTRUCTIONS
	elif item.name.to_lower() == "grill":
		instructions.text = "Grill the eggplants as is in the pan."
		instructions_2.text = "Usually you would want to keep it on heat until the skin is charred."
	elif item.name.to_lower() == "peel_and_flatten":
		instructions.text = "Peel the skin off the eggplants, and press down on it until it flattens."
		instructions_2.text = "You'd want to keep the stems attached. Gently flatten it, just enough to make an oval shape."
	elif item.name.to_lower() == "egg_crack":
		instructions.text = "Crack at least 2 eggs in a wide bowl."
		instructions_2.text = ""
	elif item.name.to_lower() == "egg_mix":
		instructions.text = "Beat/Mix the eggs together until well combined."
		instructions_2.text = ""
	elif item.name.to_lower() == "coating":
		instructions.text = "Dip the flattened eggplants into the eggs."
		instructions_2.text = "Make sure every part of it is evenly coated."
	elif item.name.to_lower() == "cook":
		instructions.text = "Add oil to the pan, and place the coated eggplants in it."
		instructions_2.text = "Fry it until the color is golden brown."
		
	
	# PANCIT INSTRUCTIONS
	elif item.name.to_lower()  == "blanching":
		instructions.text = "Fill the bowl with water."
		instructions_2.text = ""
	elif item.name.to_lower()  == "ice":
		instructions.text = "Fill the bowl with water."
		instructions_2.text = "Afterwards, fill it as well with ice."
	elif item.name.to_lower()  == "vegetables":
		instructions.text = "Add in chosen ingredients such as snap peas, carrots, and cabbages."
		instructions_2.text = "These ingredients are typically up to you!"
	# not done augh
		
	ins_anim_in.play("fade")
