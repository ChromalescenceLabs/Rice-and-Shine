extends TextureButton
const CUSTOMERS_BALLOON = preload("uid://cm4n4dbr706j")

# Textures
const LOLO = preload("uid://dg47vo7v7vwqq")
const MARITES = preload("uid://gh1at5fdem7h")
const STUDENT = preload("uid://cww1ucg2b6yl2")
const TATAY = preload("uid://crl6y8dtirpjd")


const DIALOGUE_ORDER_LABEL = preload("uid://cksm00h67pcy1")
var final_pos
var indx : int
var received_order : Dictionary
@onready var happiness_bar: ProgressBar = $HappinessBar
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

var customerTypes : Array = [
	"student",
	"lolo",
	"marites",
	"tatay"#,
	#"basketball_player",
	#"daughter",
]

func initialization() -> bool:
	self.modulate.a = 1.0
	var data = GlobalSaveManager.fetch_scene_persistent_value(GlobalSaveManager.get_scene_path())
	if not data == null:
		var node_data = GlobalSaveManager.fetch_node_persistent_value(data, "CustomerConts")
		if node_data == null:
			update_customerInfo()
	else:
		update_customerInfo()
	
	return true

func update_customerInfo():
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
		GlobalVars.show_dialogue(indx, "correct", self, null, null)
		
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
			
		order = order + str(customer_info["CustomerWants"][i]) + " " + i
		if customer_info["CustomerWants"][i] > 1:
			order = order + "s"
		
		if customer_info["CustomerWants"].size() > 1 and not dict_index == customer_info["CustomerWants"].size():
			order = order + ", "
		
	GlobalVars.character_order = order
	
	var balloon = DialogueManager.show_dialogue_balloon_scene(CUSTOMERS_BALLOON, load("uid://bivmd1klxx532"), customer_info["CustomerType"])
	balloon.global_position = self.global_position
	balloon.indx = indx


func _on_customer_area_area_entered(area: Area2D) -> void:
	if area is BowlArea: 
		var bowl = area.get_parent() as TextureRect
		bowl.set("servable", true)

func _on_customer_area_area_exited(area: Area2D) -> void:
	if area is BowlArea: 
		var bowl = area.get_parent() as TextureRect
		bowl.set("servable", false)
	
func get_order_label():
	var order_label = DIALOGUE_ORDER_LABEL.instantiate()
	
	return order_label
