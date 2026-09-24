extends Node2D

const FOOD_PICKUP = preload("uid://bp3wrjfknjyxt")

@onready var rice_cont: TextureButton = $Control/ScrollContainer/FoodConts/RiceCont
@onready var pcake_cont: TextureButton = $Control/ScrollContainer/FoodConts/PancakeCont
@onready var hbrown_cont: TextureButton = $Control/ScrollContainer/FoodConts/HashbrownCont

var rice_state = GlobalVars.rice_cont_state
var pcake_state = GlobalVars.pcake_cont_state
var hbrown_state = GlobalVars.hbrown_cont_state

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
	update_textures()
	change_textures()
	GlobalVars.is_customer_serving = true
	GlobalVars.foodValueChanged.connect(_on_food_val_changed)

func _process(_delta: float) -> void:
	change_textures()
		
func change_textures():
	change_texture(rice_state, rice_cont, textureDict.get("rice_cont"), textureDict.get("rice_conth"), textureDict.get("ricef_cont"), textureDict.get("ricef_conth"))
	change_texture(pcake_state, pcake_cont, textureDict.get("pcake_cont"), textureDict.get("pcake_conth"), textureDict.get("pcakef_cont"), textureDict.get("pcakef_conth"))
	change_texture(hbrown_state, hbrown_cont, textureDict.get("hbrown_cont"), textureDict.get("hbrown_conth"), textureDict.get("hbrownf_cont"), textureDict.get("hbrownf_conth"))
	
func update_textures():
	rice_state = GlobalVars.rice_cont_state
	pcake_state = GlobalVars.pcake_cont_state
	hbrown_state = GlobalVars.hbrown_cont_state

func change_texture(cont_state, cont, e_text, e_texth, f_text, f_texth):
	match cont_state:
		"EMPTY":
			cont.texture_normal = e_text
			cont.texture_hover = e_texth
		"FILLED":
			cont.texture_normal = f_text
			cont.texture_hover = f_texth

func check_value_forbtn(cont_state, scene: String):
	match cont_state:
		"EMPTY":
			SceneLoader.load_scene(scene, 1)
		"FILLED":
			var food = FOOD_PICKUP.instantiate()
			food.global_position = get_global_mouse_position()
			add_child(food)

func _on_food_val_changed(var_name : String, _new_value : int, current_state: String):
	match var_name:
		"rice_value": rice_state = current_state
		"pcake_value": pcake_state = current_state
		"hbrown_value": hbrown_state = current_state
		


func _on_rice_cont_button_down() -> void: check_value_forbtn(rice_state, "uid://sukerfnpt5d5")
func _on_pancake_cont_button_down() -> void: check_value_forbtn(pcake_state, "uid://bf86igy00f6sq")
func _on_hashbrown_cont_button_down() -> void: check_value_forbtn(hbrown_state, "uid://j42ywdsfuawg")
