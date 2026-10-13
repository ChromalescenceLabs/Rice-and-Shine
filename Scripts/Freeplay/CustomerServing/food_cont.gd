extends TextureButton
@onready var counter_anim: AnimationPlayer = $CounterAnim
@onready var counter: RichTextLabel = $Counter

@export var food_type : String
@export var filled_texture : Texture
@export var filled_textureh : Texture
@export var empty_texture : Texture
@export var empty_textureh : Texture

const FOOD_PICKUP = preload("uid://bp3wrjfknjyxt")

var state : String

var qty : int = 5:
	set(value):
		if not qty == value:
			qty = value
			upd_texture()
			counter.text = str(qty)

func _ready() -> void:
	counter.text = str(qty)
	upd_texture()

func _on_button_down() -> void:
	match food_type:
		"RICE": check_value_forbtn(state, "uid://sukerfnpt5d5", "rice")
		"PANCAKE": check_value_forbtn(state, "uid://bf86igy00f6sq", "pancake")
		"HASHBROWN": check_value_forbtn(state, "uid://j42ywdsfuawg", "hashbrown")

func check_value_forbtn(cont_state, scene: String, foodStr : String):
	match cont_state:
		"EMPTY":
			SceneLoader.load_scene(scene, 1)
		"FILLED":
			var food = FOOD_PICKUP.instantiate()
			food.global_position = get_global_mouse_position()
			food.texture = foodStr
			self.add_child(food)
			
			await food.tree_exiting
			
			if food.food_in_bowl == true:
				qty = qty - 1

func upd_texture():
	if qty > 0:
		state = "FILLED"
		self.texture_normal = filled_texture
		self.texture_hover = filled_textureh
	else:
		state = "EMPTY"
		self.texture_normal = empty_texture
		self.texture_hover = empty_textureh

func _on_mouse_entered() -> void: counter_anim.play("EnterExit")
func _on_mouse_exited() -> void: counter_anim.play_backwards("EnterExit")
