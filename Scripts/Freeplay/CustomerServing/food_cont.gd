extends TextureButton
@onready var counter_anim: AnimationPlayer = $CounterAnim
@onready var counter: RichTextLabel = $Counter

@export var food_type : String
@export var filled_texture : Texture
@export var filled_textureh : Texture
@export var empty_texture : Texture = preload("uid://bsqv34s5n6jua")
@export var empty_textureh : Texture = preload("uid://d4ejlsmnfb3fk")

const FOOD_PICKUP = preload("uid://bp3wrjfknjyxt")

var state : String
var textures : Dictionary = {
	"RICE": [preload("uid://pdgkrk5blfm6"), preload("uid://bx6lx7oiddght")],
	"PANCAKE": [preload("uid://bud6gaclyr7kc"), preload("uid://dmu3u6rp8tpr3")],
	"HASHBROWN": [preload("uid://c5st1ydxjpqdq"), preload("uid://bhivobiuw4dqx")],
	"LUMPIA": [preload("uid://dafnwn4p4j7hm"), preload("uid://uhja1md1q4k8")]
}

var qty : int = 5:
	set(value):
		if not qty == value:
			qty = value
			upd_texture()
			counter.text = food_type + ": " + str(qty)

func initialize() -> void:
	counter.text = food_type + ": " + str(qty)
	filled_texture = textures[food_type.to_upper()][0]
	filled_textureh = textures[food_type.to_upper()][1]
	upd_texture()

func _on_button_down() -> void:
	match food_type:
		"RICE": check_value_forbtn(state, "uid://sukerfnpt5d5", "rice")
		"PANCAKE": check_value_forbtn(state, "uid://bf86igy00f6sq", "pancake")
		"HASHBROWN": check_value_forbtn(state, "uid://j42ywdsfuawg", "hashbrown")
		"HOTDOG": check_value_forbtn(state, "uid://bgi803ffeyeae", "hotdog")
		"INIHAW": check_value_forbtn(state, "uid://cphb8p5iecw0j", "inihaw")
		"TORTA": check_value_forbtn(state, "uid://dqrhc8pu68q17", "torta")
		"LUMPIA": check_value_forbtn(state, "uid://b0yukpeuqjxne", "lumpia")

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
