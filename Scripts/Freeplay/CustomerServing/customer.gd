extends TextureButton

var customer = load("uid://bivmd1klxx532")

var final_pos
var indx : int
var received_order : Dictionary
@onready var happiness_bar: ProgressBar = $HappinessBar
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var customer_area: CustomerArea = $CustomerArea

var customer_info : Dictionary = {
	# CustomerType : String,
	# CustomerWants : Dictionary,
	# CustomerHappiness : int
}

var customerTypes : Array = [
	"student",
	"lolo",
	"marites"
	#,
	#"basketball_player",
	#"tatay_labas_tiyan",
	#"daughter",
]

func initialization() -> bool:
	self.modulate.a = 1.0
	var data = GlobalSaveManager.fetch_scene_persistent_value(GlobalSaveManager.get_scene_path())
	if data == null:
		animation_player.play("enter_exit")
		
		# Picks Customer Type
		var randType = customerTypes.pick_random()
		customer_info["CustomerType"] = randType
		
		# Picks Customer Want
		var possible_foods : Array = GlobalVars.unlocked_foods.duplicate()
		for i in randi_range(1, 3):
			var rand_food = possible_foods.pick_random()
			customer_info["CustomerWants"] = {}
			customer_info["CustomerWants"][rand_food] = randi_range(1, 5)
			possible_foods.erase(rand_food)
		print(customer_info["CustomerWants"])
			
	return true
	
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
	print(received_order)

func _on_pressed() -> void:
	var something = DialogueManager.show_dialogue_balloon(customer, customer_info["CustomerType"])
	something.global_position = self.global_position
	something.indx = indx


func _on_customer_area_area_entered(area: Area2D) -> void:
	if area is BowlArea: 
		var bowl = area.get_parent() as TextureRect
		bowl.set("servable", true)

func _on_customer_area_area_exited(area: Area2D) -> void:
	if area is BowlArea: 
		var bowl = area.get_parent() as TextureRect
		bowl.set("servable", false)
