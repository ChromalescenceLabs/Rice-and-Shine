extends TextureButton
const CUSTOMERS_BALLOON = preload("uid://cm4n4dbr706j")
@onready var order_label_animator: AnimationPlayer = $OrderLabel/OrderLabelAnimator

@onready var order_container: HBoxContainer = $OrderLabel/SmoothScrollContainer/OrderContainer
@onready var order_label: Control = $OrderLabel

# Dialogue Food Images
const HASHBROWN_LABEL_IMG = preload("uid://be4y7ewpqycrh")
const PANCAKE_LABEL_IMG = preload("uid://bu18d5et72sre")
const RICE_LABEL_IMG = preload("uid://c46do5q6bcopm")

# Textures
const LOLO = preload("uid://dg47vo7v7vwqq")
const MARITES = preload("uid://gh1at5fdem7h")
const STUDENT = preload("uid://cww1ucg2b6yl2")
const TATAY = preload("uid://crl6y8dtirpjd")

#Hapbar Icon Textures
var icon_textures : Dictionary = {
	"student" : preload("uid://cbnq3e8e222c5"),
	"lolo" : preload("uid://xjdoixqri3rb"),
	"marites" : preload("uid://cl01be381tomn"),
	"tatay" : preload("uid://dl3fu0qp4t7nq")
}

var final_pos
var received_order : Dictionary
const HAPPINESS_BAR = preload("uid://d1c4e3m2dk23a")
@onready var happiness_bar_cont: VBoxContainer = $Control/HappinessBarCont
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var customer_area: CustomerArea = $CustomerArea

var customer_info : Dictionary = {
	# CustomerType : String,
	# CustomerWants : Dictionary,
	# CustomerHappiness : int,
	# Hapbar : HBoxContainer
}

var rng = RandomNumberGenerator.new()

func _ready() -> void:
	if not GlobalScenes.add_customer.is_connected(enter):
		GlobalScenes.add_customer.connect(enter)
	rng.randomize()
	order_label.modulate.a = 0

# To Initialize the Customer's Information
func initialization(type : String = "Random", wants : Dictionary = {}) -> Variant:
	# Picks Customer Type
	if type == "Random":
		var weight = rng.rand_weighted(GlobalVars.customer_weights)
		var randType = GlobalVars.unlocked_customers[weight]
		customer_info["CustomerType"] = randType
	else:
		customer_info["CustomerType"] = type
		
	update_texture()
	
	# Picks Customer Want
	if wants.is_empty():
		var possible_foods : Array = GlobalVars.unlocked_foods.duplicate()
		customer_info["CustomerWants"] = {}
		for i in randi_range(1, 3):
			var rand_food = possible_foods.pick_random()
			customer_info["CustomerWants"][rand_food] = randi_range(1, 5)
			possible_foods.erase(rand_food)
	else:
		customer_info["CustomerWants"] = wants
		
	var hapbar = instantiate_hapbar(customer_info["CustomerType"], self)
	customer_info["Hapbar"] = hapbar
		
	return customer_info
func enter():
	GlobalScenes.add_customer.disconnect(enter)
	animation_player.play("enter_exit")
	
# Function to Update Texture Based on the Customer's Type
func update_texture() -> void:
	match customer_info["CustomerType"]:
		"student": self.texture_normal = STUDENT
		"lolo": self.texture_normal = LOLO
		"marites": self.texture_normal = MARITES
		"tatay": self.texture_normal = TATAY
		
func instantiate_hapbar(texture : String, node : TextureButton):
	var hapbar = HAPPINESS_BAR.instantiate()
	happiness_bar_cont.add_child(hapbar)
	hapbar.icon.texture = icon_textures[texture]
	hapbar.type = texture
	hapbar.associated_node = node
	
	return hapbar

func upd_colmask(layer : int): customer_area.collision_mask = layer
	
# Triggers Dialogue
func _on_pressed() -> void:
	GlobalVars.character_name = customer_info["CustomerType"][0].to_upper() + customer_info["CustomerType"].substr(1, -1)
	var order : String = ""
	var dict_index : int = 0
	for i in customer_info["CustomerWants"]:
		dict_index += 1
		
		if customer_info["CustomerWants"].size() > 1 and dict_index == customer_info["CustomerWants"].size():
			order = order + "and "
			
		# Gets type & qty
		var food_texture
		match i:
			"rice": food_texture = RICE_LABEL_IMG
			"pancake": food_texture = PANCAKE_LABEL_IMG
			"hashbrown": food_texture = HASHBROWN_LABEL_IMG
		
		# This method shows the order as images
		order = order + str(customer_info["CustomerWants"][i]) + ""
		order = order + " [img=32x32]" + str(food_texture.resource_path) + "[/img]"
		
		#This method shows the order as words
		#order = order + str(customer_info["CustomerWants"][i]) + " " + i
		#if customer_info["CustomerWants"][i] > 1:
			#order = order + "s"
		
		#Sees if a comma should be added
		if customer_info["CustomerWants"].size() > 1 and not dict_index == customer_info["CustomerWants"].size():
			order = order + ", "
		
	GlobalVars.character_order = order
	
	var balloon = DialogueManager.show_dialogue_balloon_scene(CUSTOMERS_BALLOON, load("uid://bivmd1klxx532"), customer_info["CustomerType"])
	balloon.global_position = self.global_position
	if self.global_position.x < 640:
		balloon.indx = 1
	elif self.global_position.x > 640:
		balloon.indx = 3
	
	self.disabled = true
	
	for i in customer_info["CustomerWants"]:
		var food_texture
		match i:
			"rice": food_texture = RICE_LABEL_IMG
			"pancake": food_texture = PANCAKE_LABEL_IMG
			"hashbrown": food_texture = HASHBROWN_LABEL_IMG
			
		var label_text
		label_text = "[img=32x32]" + str(food_texture.resource_path) + "[/img]"
		label_text = label_text + " x" + str(customer_info["CustomerWants"][i])
		var label = RichTextLabel.new()
		label.custom_minimum_size = Vector2(70, 0)
		label.bbcode_enabled = true
		label.scroll_active = false
		label.clip_contents = false
		label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
		label.text = label_text
		order_container.add_child(label)
		
	await DialogueManager.dialogue_ended
	order_label_animator.play("Exit_Entrance")

# For Serving Bowls
func _on_customer_area_area_entered(area: Area2D) -> void:
	if area is BowlArea: 
		var bowl = area.get_parent() as TextureRect
		bowl.set("servable", true)
func _on_customer_area_area_exited(area: Area2D) -> void:
	if area is BowlArea: 
		var bowl = area.get_parent() as TextureRect
		bowl.set("servable", false)

# Triggers when Bowl is Served
func receive_bowl(bowlContents : Dictionary, bowl : TextureRect):
	received_order = bowlContents
	bowl.queue_free()
	if received_order == customer_info["CustomerWants"]:
		GlobalVars.character_name = customer_info["CustomerType"][0].to_upper() + customer_info["CustomerType"].substr(1, -1)
		var balloon = DialogueManager.show_dialogue_balloon_scene(CUSTOMERS_BALLOON, load("uid://bivmd1klxx532"), "correct")
		balloon.global_position = self.global_position
		if self.global_position.x < 640:
			balloon.indx = 1
		elif self.global_position.x > 640:
			balloon.indx = 3
		
		await DialogueManager.dialogue_ended
		
		animation_player.play_backwards("enter_exit")
		await animation_player.animation_finished
		self.queue_free()
