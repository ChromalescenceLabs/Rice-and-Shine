extends Node2D

const FOOD_PICKUP = preload("uid://bp3wrjfknjyxt")
const SERVE_BOWL = preload("uid://curuxisd3l6in")
@onready var bowl_labels: Node2D = $BowlLabels
@onready var bowl_conts: HBoxContainer = $Control/BowlConts
@onready var freed_bowls: Control = $Control/FreedBowls

@onready var rice_cont: TextureButton = $Control/ScrollContainer/FoodConts/RiceCont
@onready var pcake_cont: TextureButton = $Control/ScrollContainer/FoodConts/PancakeCont
@onready var hbrown_cont: TextureButton = $Control/ScrollContainer/FoodConts/HashbrownCont

@onready var rice_counter: RichTextLabel = $Control/Counters/RiceCounter
@onready var pcake_counter: RichTextLabel = $Control/Counters/PcakeCounter
@onready var hbrown_counter: RichTextLabel = $Control/Counters/HbrownCounter

var rice_state = GlobalVars.rice_cont_state
var pcake_state = GlobalVars.pcake_cont_state
var hbrown_state = GlobalVars.hbrown_cont_state

@onready var add_bowl: Button = $Control/BowlConts/AddBowl
var bowl_no : int = 0

var textureDict = {
	"rice_cont" = load("uid://chv7ovq6nnca3"),
	"rice_conth" = load("uid://bfxatlh6arx51"),
	"pcake_cont" = load("uid://dlns6abi2siiy"),
	"pcake_conth" = load("uid://7hk0brvbupc2"),
	"hbrown_cont" = load("uid://cuqrumfstfqqu"),
	"hbrown_conth" = load("uid://4msdq3gandfm"),
	
	"ricef_cont" = load("uid://doy8fthnvd5lo"),
	"ricef_conth" = load("uid://svjtmt5lpf1b"),
	"pcakef_cont" = load("uid://t3ul20puiuov"),
	"pcakef_conth" = load("uid://cevrrowe651af"),
	"hbrownf_cont" = load("uid://cfu2uvbts2ldr"),
	"hbrownf_conth" = load("uid://c4jbnbugoscts"),
}

func _ready() -> void:
	update_texturesncounters()
	change_textures()
	GlobalVars.is_customer_serving = true
	GlobalVars.foodValueChanged.connect(_on_food_val_changed)

func _process(_delta: float) -> void:
	change_textures()
		
func change_textures():
	change_texture(rice_state, rice_cont, textureDict.get("rice_cont"), textureDict.get("rice_conth"), textureDict.get("ricef_cont"), textureDict.get("ricef_conth"))
	change_texture(pcake_state, pcake_cont, textureDict.get("pcake_cont"), textureDict.get("pcake_conth"), textureDict.get("pcakef_cont"), textureDict.get("pcakef_conth"))
	change_texture(hbrown_state, hbrown_cont, textureDict.get("hbrown_cont"), textureDict.get("hbrown_conth"), textureDict.get("hbrownf_cont"), textureDict.get("hbrownf_conth"))
	
func update_texturesncounters():
	rice_state = GlobalVars.rice_cont_state
	pcake_state = GlobalVars.pcake_cont_state
	hbrown_state = GlobalVars.hbrown_cont_state
	
	rice_counter.text = str(GlobalVars.rice_value)
	pcake_counter.text = str(GlobalVars.pcake_value)
	hbrown_counter.text = str(GlobalVars.hbrown_value)

func change_texture(cont_state, cont, e_text, e_texth, f_text, f_texth):
	match cont_state:
		"EMPTY":
			cont.texture_normal = e_text
			cont.texture_hover = e_texth
		"FILLED":
			cont.texture_normal = f_text
			cont.texture_hover = f_texth

func check_value_forbtn(cont_state, scene: String, foodStr : String):
	match cont_state:
		"EMPTY":
			SceneLoader.load_scene(scene, 1)
		"FILLED":
			var food = FOOD_PICKUP.instantiate()
			food.global_position = get_global_mouse_position()
			food.texture = foodStr
			add_child(food)

func _on_food_val_changed(var_name : String, new_value : int, current_state: String):
	match var_name:
		"rice_value": 
			rice_state = current_state
			rice_counter.text = str(new_value)
		"pcake_value": 
			pcake_state = current_state
			pcake_counter.text = str(new_value)
		"hbrown_value": 
			hbrown_state = current_state
			hbrown_counter.text = str(new_value)

func _on_rice_cont_button_down() -> void: check_value_forbtn(rice_state, "uid://sukerfnpt5d5", "rice")
func _on_pancake_cont_button_down() -> void: check_value_forbtn(pcake_state, "uid://bf86igy00f6sq", "pancake")
func _on_hashbrown_cont_button_down() -> void: check_value_forbtn(hbrown_state, "uid://j42ywdsfuawg", "hashbrown")

func _on_add_bowl_pressed() -> void:
	var newBowl = SERVE_BOWL.instantiate()
	newBowl.modulate.a = 0.0
	bowl_conts.add_child(newBowl)

	var last_index := bowl_conts.get_child_count() - 1
	bowl_conts.move_child(newBowl, max(0, last_index - 1))

	await get_tree().process_frame

	newBowl.initialization()
	
	bowl_no += 1
	
	if bowl_no == 7:
		add_bowl.disabled = true
		add_bowl.visible = false

func _on_freed_bowls_child_exiting_tree(node: Node) -> void:
	if node is Bowl:
		var pos = node.final_pos
		bowl_no -= 1
		
		for i in bowl_conts.get_children():
			if i.global_position == pos:
				i.queue_free()
				break
		
		if bowl_no < 7:
			add_bowl.disabled = false
			add_bowl.visible = true
		
		await node.tree_exited
		
		for i in freed_bowls.get_child_count():
			var current_back_bowl = bowl_conts.get_children()[i]
			var current_freed_bowl = freed_bowls.get_children()[i]
			
			if current_back_bowl is TextureRect:
				current_freed_bowl.final_pos = current_back_bowl.global_position
				current_freed_bowl.global_position = current_back_bowl.global_position
