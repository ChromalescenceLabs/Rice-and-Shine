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

var final_pos
var indx : int
var received_order : Dictionary
@onready var happiness_bar: ProgressBar = $Control/HappinessBar
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var customer_area: CustomerArea = $CustomerArea

var customerHappiness : int = 100: 
	set(value):
		if not customerHappiness == value:
			customerHappiness = value
			happiness_bar.value = customerHappiness
			customer_info["CustomerHappiness"].value = customerHappiness

var customer_info : Dictionary = {
	# CustomerType : String,
	# CustomerWants : Dictionary,
	# CustomerHappiness : int
}

# Have to be in the same style as the cues in the customer ordering dialogue resource
var customerTypes : Array = [
	"student",
	"lolo",
	"marites",
	"tatay"#,
	#"basketball_player",
	#"daughter",
]

func _ready() -> void:
	order_label.modulate.a = 0

func initialization() -> String:
	self.modulate.a = 1.0
	var data = GlobalSaveManager.fetch_scene_persistent_value(GlobalSaveManager.get_scene_path())
	var char_type
	if not data == null:
		var node_data = GlobalSaveManager.fetch_node_persistent_value(data, "CustomerConts")
		if node_data == null:
			char_type = update_customerInfo()
	else:
		char_type = update_customerInfo()
	
	return char_type

func update_customerInfo() -> String:
	animation_player.play("enter_exit")
		
	# Picks Customer Type
	var randType = customerTypes.pick_random()
	customer_info["CustomerType"] = randType
	update_texture()
	
	# Picks Customer Want
	var possible_foods : Array = GlobalVars.unlocked_foods.duplicate()
	customer_info["CustomerWants"] = {}
	for i in randi_range(1, 3):
		var rand_food = possible_foods.pick_random()
		customer_info["CustomerWants"][rand_food] = randi_range(1, 5)
		possible_foods.erase(rand_food)	
		
	return customer_info["CustomerType"]

func update_texture() -> void:
	match customer_info["CustomerType"]:
		"student": self.texture_normal = STUDENT
		"lolo": self.texture_normal = LOLO
		"marites": self.texture_normal = MARITES
		"tatay": self.texture_normal = TATAY
		
func upd_colmask(layer : int):
	customer_area.collision_mask = layer
	
func receive_bowl(bowlContents : Dictionary, bowl : TextureRect):
	received_order = bowlContents
	bowl.queue_free()
	if received_order == customer_info["CustomerWants"]:
		GlobalVars.character_name = customer_info["CustomerType"][0].to_upper() + customer_info["CustomerType"].substr(1, -1)
		var balloon = DialogueManager.show_dialogue_balloon_scene(CUSTOMERS_BALLOON, load("uid://bivmd1klxx532"), "correct")
		balloon.global_position = self.global_position
		balloon.indx = indx
		
		await DialogueManager.dialogue_ended
		
		animation_player.play_backwards("enter_exit")
		await animation_player.animation_finished
		self.queue_free()
		

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
	balloon.indx = indx

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

func _on_customer_area_area_entered(area: Area2D) -> void:
	if area is BowlArea: 
		var bowl = area.get_parent() as TextureRect
		bowl.set("servable", true)

func _on_customer_area_area_exited(area: Area2D) -> void:
	if area is BowlArea: 
		var bowl = area.get_parent() as TextureRect
		bowl.set("servable", false)

func _on_tree_exiting() -> void:
	get_tree().current_scene.upd_customer_indexes(indx)
